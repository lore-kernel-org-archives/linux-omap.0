From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Tue, 11 Jun 2013 16:42:30 +0200
Message-ID: <51B73756.5010004@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-11-git-send-email-bigeasy@linutronix.de> <20130611142347.GF29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20130611142347.GF29135@zurbaran>
Sender: linux-input-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Patil, Rachna" <rachna@ti.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 04:23 PM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

> On Tue, Jun 11, 2013 at 01:30:56PM +0200, Sebastian Andrzej Siewior w=
rote:
>> From: "Patil, Rachna" <rachna@ti.com>
>>
>> Make changes to add DT support in the MFD core driver.
> Which changes ?

So rewrite the commit log=85

>> [ panto@antoniou-consulting.com : use of_get_child_by_name
>> 	instead of of_find_node_by_name ]
> I have no idea where that is coming from. Please remove this kind of
> stuff and build a proper commit log instead.
>=20
>=20
>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> Signed-off-by: Patil, Rachna <rachna@ti.com>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> [bigeasy: module alias, rename to ti,am3359-tscadc as it was tested =
on
>>           AM3359]
> I honestly can't tell if this is a change from the last version of yo=
ur
> patchset or a description of this patch changes in general.
> This is cluttering your commit logs, please remove this as well.

I took the original patch. Every change I made to it because people
asked to merge changes into the patch where the problem occurred I
added it here before my sign-off.

In the end I would like not to post a patch with "From: !=3D me" and
don't make change which the original author did not do. Also dropping
their authorship isn't nice. What could we agree on?

> Cheers,
> Samuel.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
