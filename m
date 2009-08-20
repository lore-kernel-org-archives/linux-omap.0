From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [RESUBMIT][PATCH-v2][RFC] OMAP4: I2C Support for OMAP4430
Date: Thu, 20 Aug 2009 22:18:55 +0100
Message-ID: <20090820211855.GA13455@fluff.org.uk>
References: <54914.192.168.10.89.1248270620.squirrel@dbdmail.itg.ti.com> <58468.192.168.10.89.1248433802.squirrel@dbdmail.itg.ti.com> <20090729235150.GE8850@fluff.org.uk> <45002.192.168.10.88.1250589931.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <45002.192.168.10.88.1250589931.squirrel-pJFUjGLopx31T2qfsofKZtBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 18, 2009 at 03:35:31PM +0530, Syed Rafiuddin wrote:
> Ben,
> 
> > On Fri, Jul 24, 2009 at 04:40:02PM +0530, Syed Rafiuddin wrote:
> >> Hi Ben,
> >>
> >> > This patch adds OMAP4 support to the I2C driver. All I2C register addresses  are different
> >> between
> >> > OMAP1/2/3 and OMAP4. In order to not have #ifdef's at  various places in code, as well as to
> >> > support multi-OMAP build, Array's are  created to hold the register addresses.
> >> >
> >> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
> >> > ---
> >>
> >> No comment received on this patch,
> >> Is there anything that I need to resolve?
> >> Else can this patch get merged.
> >
> > sorry, been busy, will look at this in the next few days.
> 
> Seems like no issues with the patch since no comments received from long time.
> Did you get a chance to look at the patch.Could you please merge this.

I can't currently think of any neater way of doing this, so i'll
probably merge this.
 
> Regards,
> Syed Rafiuddin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
