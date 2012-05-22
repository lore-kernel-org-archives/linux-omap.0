From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/7] remoteproc: resource table overhaul
Date: Tue, 22 May 2012 07:51:52 +0200
Message-ID: <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
 <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
 <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9021937967906846953=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>, Anna Suman <s-anna@ti.com>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Arnd Bergmann <arnd@arndb.de>, Iliyan Malchev <malchev@google.com>, Brian Swetland <swetland@google.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, John Williams <john.williams@petalogix.com>, Clark Rob <rob@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Kieran Bingham <kieranbingham@gmail.com>, Mark Grosen <mgrosen@ti.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

--===============9021937967906846953==
Content-Type: multipart/alternative; boundary=047d7b33cb468f934b04c0999d3f

--047d7b33cb468f934b04c0999d3f
Content-Type: text/plain; charset=ISO-8859-1

Hi Ohad and Ludovic,

2012/5/21 Ohad Ben-Cohen <ohad@wizery.com>

> Hi Michal,
>
> On Mon, May 21, 2012 at 4:02 PM, Michal Simek <monstr@monstr.eu> wrote:
> > I have looked at it and tested on latest and greatest and the problem is
> > still there.
>
> Ok, I see why this is happening.
>
> We're now allocating the vrings' DMA in ->find_vqs() just before we
> boot the remote processor, and we release it on ->del_vqs(). These are
> the virtio handlers for setting up and tearing down the vrings, so it
> makes sense to do so, but as a result, we still don't get the early
> carveout allocation you wanted.
>
> > I have looked at the code and path is
> > rproc_fw_config_virtio -> rproc_handliefirtion_rsc -> rproc_handle_vdev
>
> Please note that rproc_handle_vdev doesn't allocate any DMA at this
> point, and the allocation path is now quite different - it begins with
> virtio_rpmsg_bus probing and then calling into the ->find_vqs()
> handler.
>

> > For me it is necessary to ensure that dma_alloc_coherent in
> > rproc_alloc_vring is called after carveout allocation
> > just because dma_alloc_cohorent takes mermory from preallocated pool
> which
> > starts at 0x0.
>
> ok.
>
> > I also don't have
> > any other advance mechanism how to ensure mapping for the second arm
> core.
>
> Probably the best way to ensure this (without it breaking unexpectedly
> again as remoteproc evolves) is to have separate sub-devices for
> different kind of memories, which remoteproc could then look up using
> something like device_find_child().
>
> Ludovic is exploring this direction too, because STE also needs to
> bind specific memory regions with predefined purposes, without
> depending on the order of DMA allocations.
>

It is good that someone else has similar requirements.


>
> I think Ludovic already has a preliminary patch which he may be able
> to share with you.
>

Ludovic: Can you share your patch with us? I would like to try it.


>
> > Here is log which I need to get. Look at attached patch which exactly
> show
> > you what I need to do which I have tested.
>
> Yes, I see. Another temporary approach might be moving the vrings'
> allocations to the rproc_handle_rsc table (in the RSC_VDEV slot), but
> I'm not sure we want to merge this as well because this solution too
> is only hiding the real issue and not solving it permanently.
>
>
Simple enabling RSC_VDEV in rproc_handle_rsc doesn't work.

BTW: I am using kernel modules and there is no dependency for
virtio_rpmsg_bus in remoteproc module
in sense if you load remoteproc module you also need to load
virtio_rpmsg_bus to get firmware to work.

I think that will be good to create that dependency automatically because
you need to load virtio_rpmsg_bus
when you problem remoteproc module.

~ # lsmod
~ # modprobe zynq_remoteproc
zynq_remoteproc: Unknown symbol rproc_register (err 0)
zynq_remoteproc: Unknown symbol rproc_alloc (err 0)
zynq_remoteproc: Unknown symbol rproc_vq_interrupt (err 0)
zynq_remoteproc: Unknown symbol rproc_free (err 0)
zynq_remoteproc: Unknown symbol rproc_unregister (err 0)
CPU1: shutdown
zynq_remoteproc 0.remoteproc-test: 0.remoteproc-test is available
zynq_remoteproc 0.remoteproc-test: Note: remoteproc is still under
development and considered experimental.
zynq_remoteproc 0.remoteproc-test: THE BINARY FORMAT IS NOT YET FINALIZED,
and backward compatibility isn't yet guaranteed.
~ # zynq_remoteproc 0.remoteproc-test: registered virtio0 (type 7)

~ # lsmod
zynq_remoteproc 4346 0 - Live 0xbf01f000
remoteproc 13831 1 zynq_remoteproc, Live 0xbf018000
virtio 2840 1 remoteproc, Live 0xbf008000
virtio_ring 4965 1 remoteproc, Live 0xbf013000
~ #
~ # modprobe virtio_rpmsg_bus
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test
zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 2351790
zynq_remoteproc 0.remoteproc-test: remote processor 0.remoteproc-test is
now up
virtio_rpmsg_bus virtio0: rpmsg host is online
virtio_rpmsg_bus virtio0: creating channel rpmsg-timer-statistic addr 0x50
~ #
~ # lsmod
virtio_rpmsg_bus 7575 0 - Live 0xbf024000
zynq_remoteproc 4346 1 - Live 0xbf01f000
remoteproc 13831 1 zynq_remoteproc, Live 0xbf018000
virtio 2840 2 virtio_rpmsg_bus,remoteproc, Live 0xbf008000
virtio_ring 4965 2 virtio_rpmsg_bus,remoteproc, Live 0xbf013000
~ #

Can you see the same behavior on omap?

Thanks,
Michal

--047d7b33cb468f934b04c0999d3f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ohad and Ludovic,<br><br><div class=3D"gmail_quote">2012/5/21 Ohad Ben-C=
ohen <span dir=3D"ltr">&lt;<a href=3D"mailto:ohad@wizery.com" target=3D"_bl=
ank">ohad@wizery.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Michal,<br>
<div class=3D"im"><br>
On Mon, May 21, 2012 at 4:02 PM, Michal Simek &lt;<a href=3D"mailto:monstr@=
monstr.eu">monstr@monstr.eu</a>&gt; wrote:<br>
&gt; I have looked at it and tested on latest and greatest and the problem =
is<br>
&gt; still there.<br>
<br>
</div>Ok, I see why this is happening.<br>
<br>
We&#39;re now allocating the vrings&#39; DMA in -&gt;find_vqs() just before=
 we<br>
boot the remote processor, and we release it on -&gt;del_vqs(). These are<b=
r>
the virtio handlers for setting up and tearing down the vrings, so it<br>
makes sense to do so, but as a result, we still don&#39;t get the early<br>
carveout allocation you wanted.<br>
<div class=3D"im"><br>
&gt; I have looked at the code and path is<br>
&gt; rproc_fw_config_virtio -&gt; rproc_handliefirtion_rsc -&gt; rproc_hand=
le_vdev<br>
<br>
</div>Please note that rproc_handle_vdev doesn&#39;t allocate any DMA at th=
is<br>
point, and the allocation path is now quite different - it begins with<br>
virtio_rpmsg_bus probing and then calling into the -&gt;find_vqs()<br>
handler. <br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<div class=3D"im"><br>
&gt; For me it is necessary to ensure that dma_alloc_coherent in<br>
&gt; rproc_alloc_vring is called after carveout allocation<br>
&gt; just because dma_alloc_cohorent takes mermory from preallocated pool w=
hich<br>
&gt; starts at 0x0.<br>
<br>
</div>ok.<br>
<div class=3D"im"><br>
&gt; I also don&#39;t have<br>
&gt; any other advance mechanism how to ensure mapping for the second arm c=
ore.<br>
<br>
</div>Probably the best way to ensure this (without it breaking unexpectedl=
y<br>
again as remoteproc evolves) is to have separate sub-devices for<br>
different kind of memories, which remoteproc could then look up using<br>
something like device_find_child().<br>
<br>
Ludovic is exploring this direction too, because STE also needs to<br>
bind specific memory regions with predefined purposes, without<br>
depending on the order of DMA allocations.<br></blockquote><div><br>It is g=
ood that someone else has similar requirements.<br>=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">

<br>
I think Ludovic already has a preliminary patch which he may be able<br>
to share with you.<br></blockquote><div><br>Ludovic: Can you share your pat=
ch with us? I would like to try it.<br>=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">

<div class=3D"im"><br>
&gt; Here is log which I need to get. Look at attached patch which exactly =
show<br>
&gt; you what I need to do which I have tested.<br>
<br>
</div>Yes, I see. Another temporary approach might be moving the vrings&#39=
;<br>
allocations to the rproc_handle_rsc table (in the RSC_VDEV slot), but<br>
I&#39;m not sure we want to merge this as well because this solution too<br=
>
is only hiding the real issue and not solving it permanently.<br>
<br></blockquote><div><br>Simple enabling RSC_VDEV in rproc_handle_rsc does=
n&#39;t work.<br><br>BTW: I am using kernel modules and there is no depende=
ncy for virtio_rpmsg_bus in remoteproc module<br>in sense if you load remot=
eproc module you also need to load virtio_rpmsg_bus to get firmware to work=
.<br>
<br>I think that will be good to create that dependency automatically becau=
se you need to load virtio_rpmsg_bus<br>when you problem remoteproc module.=
<br><br>~ # lsmod<br>~ # modprobe zynq_remoteproc<br>zynq_remoteproc: Unkno=
wn symbol rproc_register (err 0)<br>
zynq_remoteproc: Unknown symbol rproc_alloc (err 0)<br>zynq_remoteproc: Unk=
nown symbol rproc_vq_interrupt (err 0)<br>zynq_remoteproc: Unknown symbol r=
proc_free (err 0)<br>zynq_remoteproc: Unknown symbol rproc_unregister (err =
0)<br>
CPU1: shutdown<br>zynq_remoteproc 0.remoteproc-test: 0.remoteproc-test is a=
vailable<br>zynq_remoteproc 0.remoteproc-test: Note: remoteproc is still un=
der development and considered experimental.<br>zynq_remoteproc 0.remotepro=
c-test: THE BINARY FORMAT IS NOT YET FINALIZED, and backward compatibility =
isn&#39;t yet guaranteed.<br>
~ # zynq_remoteproc 0.remoteproc-test: registered virtio0 (type 7)<br><br>~=
 # lsmod<br>zynq_remoteproc 4346 0 - Live 0xbf01f000<br>remoteproc 13831 1 =
zynq_remoteproc, Live 0xbf018000<br>virtio 2840 1 remoteproc, Live 0xbf0080=
00<br>
virtio_ring 4965 1 remoteproc, Live 0xbf013000<br>~ # <br>~ # modprobe virt=
io_rpmsg_bus<br>zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc=
-test<br>zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 235=
1790<br>
zynq_remoteproc 0.remoteproc-test: remote processor 0.remoteproc-test is no=
w up<br>virtio_rpmsg_bus virtio0: rpmsg host is online<br>virtio_rpmsg_bus =
virtio0: creating channel rpmsg-timer-statistic addr 0x50<br>~ # <br>~ # ls=
mod<br>
virtio_rpmsg_bus 7575 0 - Live 0xbf024000<br>zynq_remoteproc 4346 1 - Live =
0xbf01f000<br>remoteproc 13831 1 zynq_remoteproc, Live 0xbf018000<br>virtio=
 2840 2 virtio_rpmsg_bus,remoteproc, Live 0xbf008000<br>virtio_ring 4965 2 =
virtio_rpmsg_bus,remoteproc, Live 0xbf013000<br>
~ # <br><br>Can you see the same behavior on omap?<br><br>Thanks,<br>Michal=
<br><br><br><br><br><br></div><div><br><br>=A0</div></div><br>

--047d7b33cb468f934b04c0999d3f--


--===============9021937967906846953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9021937967906846953==--
