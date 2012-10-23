From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: omap5: Update GPIO with address space
 and interrupts
Date: Tue, 23 Oct 2012 18:15:54 -0500
Message-ID: <5087252A.50203@ti.com>
References: <1350981432-6750-1-git-send-email-s-guiriec@ti.com>
 <1350981432-6750-2-git-send-email-s-guiriec@ti.com> <5086AE8E.60106@ti.com>
 <5086CC02.6070801@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5086CC02.6070801-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sebastien Guiriec <s-guiriec-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mitch,

On 10/23/2012 11:55 AM, Mitch Bradley wrote:
> On 10/23/2012 4:49 AM, Jon Hunter wrote:
> 
>> Therefore, I believe it will improve search time and hence, boot time if
>> we have interrupt-parent defined in each node.
> 
> I strongly suspect (based on many years of performance tuning, with
> special focus on boot time) that the time difference will be completely
> insignificant.  The total extra time for walking up the interrupt tree
> for every interrupt in a large system is comparable to the time it takes
> to send a few characters out a UART.  So you can get more improvement
> from eliminating a single printk() than from globally adding per-node
> interrupt-parent.
> 
> Furthermore, the cost of processing all of the interrupt-parent
> properties is probably similar to the cost of the avoided tree walks.
> 
> CPU cycles are very fast compared to I/O register accesses, say a factor
> of 100.  Now consider that many modern devices contain embedded
> microcontrollers (SD cards, network interface modules, USB hubs and
> devices, ...), and those devices usually require various delays measured
> in milliseconds, to ensure that the microcontroller is ready for the
> next initialization step.  Those delays are extremely long compared to
> CPU cycles.  Obviously, some of that can be overlapped by careful
> multithreading, but that isn't free either.
> 
> The bottom line is that I'm pretty sure that adding per-node
> interrupt-parent would not be worthwhile from the standpoint of speeding
> up boot time.

Absolutely, I don't expect this to miraculously improve the boot time or
suggest that this is a major contributor to boot time, but what is the
best approach in general in terms of efficiency (memory and time). In
other words, is there a best practice? And from your feedback, I
understand that adding a global interrupt-parent is a good practice.

For a bit of fun, I took an omap4430 board and benchmarked the time
taken by the of_irq_find_parent() when interrupt-parent was defined for
each node using interrupts and without.

There were a total of 47 device nodes using interrupts. Adding the
interrupt-parent to all 47 nodes increased the dtb from 13211 bytes to
13963 bytes.

On boot-up I saw 117 calls to of_irq_find_parent() for this platform
(there appears to be multiple calls for a given device). Without
interrupt-parent defined for each node total time spent in
of_irq_find_parent() was 1.028 ms where as with interrupt-parent defined
for each node the total time was 0.4032 ms. This was done using a
38.4MHz timer and the overhead of reading the timer 117 times was about
36 us.

I understand that this does not provide the full picture, but I wanted
to get a better handle on the times here. So yes the overall overhead
here is not significant for us to worry about.

Cheers
Jon
