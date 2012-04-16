From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: omap-serial: transmission of x-char with DMA (and other issues)
Date: Mon, 16 Apr 2012 16:39:09 +0530
Message-ID: <CAMrsUd+Wr=txEKSa=R0ybbd2k5Wue=KZzt82ZMtszL=7_moRLA@mail.gmail.com>
References: <20120413104111.GF25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120413104111.GF25053@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 13, 2012 at 4:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Can someone tell me how this works with the current omap-serial drive=
r
> please? =A0It looks to me like this has been broken when DMA support =
was
> added to the driver.

Yes x-char transmission in dma case is broken will post a patch to fix =
this.

>
> Moreover, please look at the probe function error paths. =A0They seem=
 to
> be lacking any kind of realistic cleanup, so are a potential memory l=
eak.

I thought this is fixed in 3.4-rc3 with this commit:

commit 388bc26226807fbcf4c626b81bb17a2e74aa4b1b
Author: Shubhrajyoti D <shubhrajyoti@ti.com>
Date:   Wed Mar 21 17:22:22 2012 +0530

    omap-serial: Fix the error handling in the omap_serial probe


>
> Then there's the issue of fiddling with the xmit buffer so that it's
> using coherent memory in the startup and shutdown functions (why? =A0=
when
> other serial drivers cope just fine without doing this). =A0If we wan=
t to
> use DMA coherent memory there, there should be a clean way to do this=
,
> rather than going behind the upper layers.

Okay I will have a look into this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
