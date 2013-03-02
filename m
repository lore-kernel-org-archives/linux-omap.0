From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Sat, 02 Mar 2013 20:05:24 +0000
Message-ID: <20130302200524.D230F3E1571@localhost>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com>
 <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com>
 <4F452484.5080503@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <512D3EC2.6050408-l0cyMroinI0@public.gmane.org>
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
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 26 Feb 2013 17:01:22 -0600, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
> 
> On 02/26/2013 04:44 PM, Stephen Warren wrote:
> > On 02/26/2013 03:40 PM, Jon Hunter wrote:
> >> On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:
> >> Are you requesting the gpio anywhere? If not then this is not going to
> >> work as-is. This was discussed fairly recently [1] and the conclusion
> >> was that the gpio needs to be requested before we can use as an interrupt.
> > 
> > That seems wrong; the GPIO/IRQ driver should handle this internally. The
> > Ethernet driver shouldn't know/care whether the interrupt it's given is
> > some form of dedicated interrupt or a GPIO-based interrupt, and even if
> > it somehow did, there's no irq_to_gpio() any more, so the driver can't
> > tell which GPIO ID it should request, unless it's given yet another
> > property to represent this.
> 
> I agree that ideally this should be handled internally. Did you read the
> discussion on the thread that I referenced [1]? If you have any thoughts
> we are open to ideas :-)

I'm on an airplane right now, but I agree 100% with Stephen. I'll try to
remember to go read that thread and respond, but this falls firmly in
the its-a-bug category for me.  :-)

g.
