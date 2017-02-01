From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Date: Wed, 1 Feb 2017 19:50:16 -0300
Message-ID: <8810e197-f071-5a3d-c376-8c365fb60640@osg.samsung.com>
References: <cover.1482936802.git.hns@goldelico.com>
 <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com>
 <20170128193558.GC38136@dtor-ws>
 <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
 <20170129180108.GA10743@dtor-ws>
 <A169CC1E-9EC9-43CA-887B-1382F1903CE1@goldelico.com>
 <B64DBFB0-62E8-4B4C-957F-C90C33BEF693@goldelico.com>
 <cc403765-9b88-1424-a77f-36e775fbd5a0@osg.samsung.com>
 <20170201222832.GA25554@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170201222832.GA25554@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Dmitry,

On 02/01/2017 07:28 PM, Dmitry Torokhov wrote:

[snip]

>>
>> As said, changing the core is trivial. A RFC patch is [0].
>>
>> The problem is how to make sure that this change won't cause regressions
>> in existing drivers.
> 
> If the concern with drivers having I2C or SPI device table, but not OF
> device table, then I think cocinnelle could be used to scan and find
> them.
>

I don't think coccinelle is a good fit for this since you may have to look if
a DTS is using in its compatible string a device that's in an SPI table or if
a DT binding documents this device as a compatible string.

But yes I get your point and I agree that is just a matter of having a script
to look for these. Someone should have the time to write it though :)

>>
>> There was particularly tricky for the spi-nor driver, it doesn't help that
>> a lot of DT are using undocumented compatible strings (sometimes with no
>> vendor prefix). You can see the discussion here [1].
>>
>> In the same thread Mark Brown said that it wasn't that bad to have the
>> information in the OF device ID table duplicated in a SPI device table.
>>
>> Certainly isn't the best approach but IMHO is better than the module not
>> loading.
> 
> You can always build the module into kernel or load it by hand if it is
> that important. Module autoloading does not work anyway if you have
> several compatible strings, like
> 
> 	compatible = "vendor,new-device", "vendor,generic-device";
> 
> Thanks.
>

Agree.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
