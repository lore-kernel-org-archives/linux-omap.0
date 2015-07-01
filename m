From: Tom Mises <tommises-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: High CPU usage when video streaming on EHCI, 3.17.8 kernel with
 DMA enabled
Date: Wed, 1 Jul 2015 12:22:14 -0600
Message-ID: <CALmG-ARrzJ=kRH-958F20WPH+=VCpjrgMuyn9MWv4uj2dnSRpw@mail.gmail.com>
References: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA@mail.gmail.com>
	<Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
	<20150518102715.34e29c33@perruche.parrot.biz>
	<20150518145919.GC10274@atomide.com>
	<CAK8F28mdedXgL660SqTLeNZ7hVHOmRR7YwuTdkyY3XmnZ97_Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8F28mdedXgL660SqTLeNZ7hVHOmRR7YwuTdkyY3XmnZ97_Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-uvc-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I has been some time, but I have an update to share.

On Sun, May 17, 2015 at 8:06 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> You might be able to learn more from ftrace.  See the instructions in
> Documentation/trace/ftrace.txt.  The "irqsoff" tracer may be the best
> one to try.

I used ftrace with the irqoff tracer as recommended. irqoff seems to
have some known issues on ARM and it traces the idle process, however,
I was able to get some meaningful output when running this tracer for
a very short time. I ran the function_graph tracer as well, which is
quite informative, but it also adds a lot of overhead.

On Mon, May 18, 2015 at 2:27 AM, Matthieu CASTET
<matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org> wrote:
> last time I checked uvc driver, it was doing memcpy of video buffer : see uvc_video_decode_data.

I found out Matthieu was on the right track and most of the time is
indeed spent in uvc_video_decode_data(), which uses memcpy() to copy
the URBs to the video buffers. For 1280x960px 15fps single 8-bit
channel,  uvc_video_decode_data() seems to consume between 40% and
50%. What is still a mystery to me is why I see relatively high CPU
usage even for a very tiny resolution. I was able to confirm that it
is not uvc_video_decode_data() in that case, however, given
function_graph overhead and irqoff being partially broken I was unable
to figure out much more.

I attached some tracer outputs at the end.

On Mon, May 18, 2015 at 8:59 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> For the memcpy part with DMA this patch should help too:
>
> [PATCH] dmaengine: omap-dma: Add support for memcpy

The patch should help, but not out of the box as far as I understand.
My understanding is that to take advantage of this, it would be
necessary to explicitly call the DMA API either by replacing memcpy()
in uvc_video_decode_data() or by modyfying the memcpy()
implementation. Is that correct?


*******************************************
/sys/kernel/debug/tracing# echo 0 > tracing_max_latency && echo 1 >
tracing_on && usleep 10 && echo 0 > tracing_on
# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 3.17.8-custom
# --------------------------------------------------------------------
# latency: 579 us, #26/26, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #P:1)
#    -----------------
#    | task: sshd-2980 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: __usb_hcd_giveback_urb
#  => ended at:   __usb_hcd_giveback_urb
#
#
#                  _------=> CPU#
#                 / _-----=> irqs-off
#                | / _----=> need-resched
#                || / _---=> hardirq/softirq
#                ||| / _--=> preempt-depth
#                |||| /     delay
#  cmd     pid   ||||| time  |   caller
#     \   /      |||||  \    |   /
    sshd-2980    0d.s.    0us : trace_hardirqs_on <-tasklet_action
    sshd-2980    0d.s.    0us : time_hardirqs_on <-tasklet_action
    sshd-2980    0d.s.    0us : trace_hardirqs_off <-_raw_spin_lock_irq
    sshd-2980    0d.s.    0us : trace_hardirqs_on <-_raw_spin_unlock_irq
    sshd-2980    0d.s.    0us : time_hardirqs_on <-_raw_spin_unlock_irq
    sshd-2980    0d.s.    0us+: trace_hardirqs_off <-__usb_hcd_giveback_urb
    sshd-2980    0d.s.   31us : uvc_video_complete <-__usb_hcd_giveback_urb
    sshd-2980    0d.s.   31us : uvc_video_decode_bulk <-uvc_video_complete
    sshd-2980    0d.s.   31us : uvc_video_decode_start <-uvc_video_decode_bulk
    sshd-2980    0d.s.   31us : ktime_get_ts64 <-uvc_video_decode_start
    sshd-2980    0d.s.   31us : clocksource_mmio_readl_up <-ktime_get_ts64
    sshd-2980    0d.s.   31us!: uvc_video_decode_data.isra.17
<-uvc_video_decode_bulk
    sshd-2980    0d.s.  519us : usb_submit_urb <-uvc_video_complete
    sshd-2980    0d.s.  519us : usb_hcd_submit_urb <-usb_submit_urb
    sshd-2980    0d.s.  519us : usb_get_urb <-usb_hcd_submit_urb
    sshd-2980    0d.s.  519us : usb_hcd_map_urb_for_dma <-usb_hcd_submit_urb
    sshd-2980    0d.s.  519us+: ehci_urb_enqueue <-usb_hcd_submit_urb
    sshd-2980    0d.s.  549us : qh_urb_transaction <-ehci_urb_enqueue
    sshd-2980    0d.s.  549us : ehci_qtd_alloc.isra.71 <-qh_urb_transaction
    sshd-2980    0d.s.  549us : dma_pool_alloc <-ehci_qtd_alloc.isra.71
    sshd-2980    0d.s.  549us : qtd_fill.isra.54 <-qh_urb_transaction
    sshd-2980    0d.s.  549us : usb_hcd_link_urb_to_ep <-ehci_urb_enqueue
    sshd-2980    0d.s.  549us+: qh_append_tds <-ehci_urb_enqueue
    sshd-2980    0d.s.  580us : trace_hardirqs_on <-__usb_hcd_giveback_urb
    sshd-2980    0d.s.  580us+: time_hardirqs_on <-__usb_hcd_giveback_urb
    sshd-2980    0d.s.  671us : <stack trace>
 => trace_hardirqs_on
 => __usb_hcd_giveback_urb
 => usb_giveback_urb_bh
 => tasklet_action
 => __do_softirq
 => irq_exit
 => handle_IRQ
 => omap3_intc_handle_irq
 => __irq_usr
 =>
*******************************************


*******************************************
# tracer: function_graph
#
#     TIME      DURATION            FUNCTION CALLS
#      |         |   |              |   |   |   |
 5853.350952   0.000 us    | do_raw_spin_lock();
 5853.350952   0.000 us    | do_raw_spin_unlock();
 5853.350952               | __usb_hcd_giveback_urb() {
 5853.350952               |   unmap_urb_for_dma() {
 5853.350982               |     usb_hcd_unmap_urb_for_dma() {
 5853.350982   0.000 us    |       usb_hcd_unmap_urb_setup_for_dma();
 5853.350982   0.000 us    |     } /* usb_hcd_unmap_urb_for_dma */
 5853.350982 + 30.517 us   |   } /* unmap_urb_for_dma */
 5853.350982   0.000 us    |   usb_anchor_suspend_wakeups();
 5853.350982   0.000 us    |   usb_unanchor_urb();
 5853.351013               |   uvc_video_complete [uvcvideo]() {
 5853.351013   0.000 us    |     do_raw_spin_lock();
 5853.351013   0.000 us    |     do_raw_spin_unlock();
 5853.351043               |     uvc_video_decode_bulk [uvcvideo]() {
 5853.351043 ! 457.763 us  |       uvc_video_decode_data.isra.17 [uvcvideo]();
 5853.351501 ! 457.763 us  |     } /* uvc_video_decode_bulk [uvcvideo] */
 5853.351501               |     usb_submit_urb() {
 5853.351501               |       usb_hcd_submit_urb() {
 5853.351501   0.000 us    |         usb_get_urb();
 5853.351501   0.000 us    |         usb_hcd_map_urb_for_dma();
 5853.351531               |         ehci_urb_enqueue() {
 5853.351531               |           qh_urb_transaction() {
 5853.351531               |             ehci_qtd_alloc.isra.71() {
 5853.351531               |               dma_pool_alloc() {
 5853.351531   0.000 us    |                 do_raw_spin_lock();
 5853.351562   0.000 us    |                 do_raw_spin_unlock();
 5853.351562 + 30.517 us   |               } /* dma_pool_alloc */
 5853.351562 + 30.517 us   |             } /* ehci_qtd_alloc.isra.71 */
 5853.351562   0.000 us    |             qtd_fill.isra.54();
 5853.351562 + 30.517 us   |           } /* qh_urb_transaction */
 5853.351593   0.000 us    |           do_raw_spin_lock();
 5853.351593               |           usb_hcd_link_urb_to_ep() {
 5853.351593               |             _raw_spin_lock() {
 5853.351593   0.000 us    |               do_raw_spin_lock();
 5853.351593   0.000 us    |             } /* _raw_spin_lock */
 5853.351623               |             _raw_spin_unlock() {
 5853.351623   0.000 us    |               do_raw_spin_unlock();
 5853.351623   0.000 us    |             } /* _raw_spin_unlock */
 5853.351623 + 30.518 us   |           } /* usb_hcd_link_urb_to_ep */
 5853.351623   0.000 us    |           qh_append_tds();
 5853.351654   0.000 us    |           do_raw_spin_unlock();
 5853.351654 ! 122.070 us  |         } /* ehci_urb_enqueue */
 5853.351654 ! 152.588 us  |       } /* usb_hcd_submit_urb */
 5853.351654 ! 152.588 us  |     } /* usb_submit_urb */
 5853.351654 ! 640.869 us  |   } /* uvc_video_complete [uvcvideo] */
 5853.351654               |   handle_IRQ() {
 5853.351715   0.000 us    |     idle_cpu();
 5853.351715 + 30.517 us   |   } /* handle_IRQ */
 5853.351715   0.000 us    |   usb_anchor_resume_wakeups();
 5853.351715 + 30.518 us   |   usb_free_urb();
 5853.351745 ! 793.457 us  | } /* __usb_hcd_giveback_urb */
*******************************************


Tom
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
