From: Jagadeesh Bhaskar Pakaravoor <jagadeeshbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][RFC] OMAP4: I2C Support for OMAP_4430SDP
Date: Thu, 4 Jun 2009 16:41:36 -0500
Message-ID: <561678670906041441y4c592e61h71fd3cf6869bcf46@mail.gmail.com>
References: <55272.192.168.10.89.1243607905.squirrel@dbdmail.itg.ti.com>
	 <878wkghqzi.fsf@deeprootsystems.com>
	 <782515bb0905291052h1d70be5em7cfdeeda903c39fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <782515bb0905291052h1d70be5em7cfdeeda903c39fc-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> why is this 2600? omap3 could do 3.3Mhz.
>
There is a silicon issue reported on TWL5030 which says that it can
not operate at the stipulated highest frequency of 3.3MHz.

The information I got is this:
"I2C data hold time in HS mode is higher than specification when
reading I2C registers. This leads to a data setup issue which
introduces a frequency limitation in HS mode (can not reach 3.4MHz as
specified in I2C standard). The limitation is for the Control I2C, and
for SmartReflex I2C when using other products than OMAP34xx with SR.
HS mode is working OK for SR I2C when using OMAP34xx."

--=20
With regards,

Jagadeesh Bhaskar P
--------------------
Bugs are by far the largest and most successful class of entity, with
nearly a million known species. In this respect they outnumber all the
other known creatures about four to one.
=97Professor Snopes' Encyclopedia of Animal Life
-------
