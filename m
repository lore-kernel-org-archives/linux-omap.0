From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: FW: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
Date: Tue, 13 Mar 2012 07:52:05 -0600
Message-ID: <20120313135205.804843E0B1B@localhost>
References: <79CD15C6BA57404B839C016229A409A831810F81@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A831810F81-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 12 Mar 2012 10:27:10 +0000, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org> wrote:
> Grant,
> 
> Sorry for writing you privately...
> 
> There are some DTS patches pending for you ACK, can you please
> Ack them so that Benoit can pull in for v3.4?

We've gotten to the point where I no longer need to ack each and every DT related
patch.  I'm not the only one capable of good DT review.  As long as someone with
good DT background looks at them (like Arnd, Rob, me, or Shawn) then you're okay
to merge.

g.

> 
> Thanks,
> Vaibhav
> 
> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Thursday, March 01, 2012 4:09 AM
> To: Tony Lindgren
> Cc: Hiremath, Vaibhav; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
> Subject: Re: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
> 
> On 2/29/2012 11:31 PM, Tony Lindgren wrote:
> > * Hiremath, Vaibhav<hvaibhav-l0cyMroinI0@public.gmane.org>  [120105 02:46]:
> ...
> >> Can this merged? OR anybody has any comments here?
> >
> > For reference, looks like this one is queued up as
> > commit f0e15e2b0c6b3e89daade25a1e9a2d80136c14c3.
> 
> Yes, it is, I included it in my DTS pull-request because it was the only 
> one with Grant's ack.
> 
> I have the whole series ready to be pulled but was waiting for DT 
> maintainers acked-by.
> 
> I still have these four ones in my branch.
> 
> d5c9442 arm/dts: Add support for TI AM3517/05 EVM board
> 3b5fa9a arm/dts: omap3-evm: Add i2c and twl4030 support
> 7f4ca5f arm/dts: Add support for TI AM335x EVM board
> d0c3aca ARM: OMAP2+: board-generic: Add DT support for AM33xx devices
> 
> In fact the board one already has the proper ack, only the DTS are 
> missing it.
> 
> Regards,
> Benoit

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
