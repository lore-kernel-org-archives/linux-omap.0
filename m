From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
Date: Tue, 3 Jan 2017 12:11:03 -0800
Message-ID: <20170103201103.GB25222@atomide.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
 <CB5C8999-6CAE-41F6-85A6-D2A856BD8011@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CB5C8999-6CAE-41F6-85A6-D2A856BD8011-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [161228 13:27]:
> 
> 
> > On Dec 27, 2016, at 11:58 AM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > 
> > BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
> > replaced by a TI wl1835 wireless module.
> > 
> > This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
> > BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
> 
> I believe the correct statement is BWxx, but BWBx reserves the option to be software incompatible in some way. My preference is to have it boot anyway, but I believe that is only dependent in the bootloader. 

So does this patch need updating for that?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
