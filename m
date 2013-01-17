From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport power
 functions
Date: Thu, 17 Jan 2013 10:59:12 +0100
Message-ID: <50F7CB70.5010003@ti.com>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>  <50F7C4A7.5060202@ti.com> <1358415316.6252.20.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358415316.6252.20.camel@cumari.coelho.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Luca,

On 01/17/2013 10:35 AM, Luciano Coelho wrote:
>> I just wonder how this is going to work with DT... You are not going=
 to have
>> the ability to use callback in this form.
>> I think the GPIO handling should be done in the driver itself rather=
 than in
>> the board file.
>=20
> I agree.  The problem is that it used to be in the ti-st driver itsel=
f,
> but it has been removed in a patch that says "different platforms hav=
e
> begun to have their own ways to power-up/down the chip." (eccf2979
> drivers/misc/ti-st: remove gpio handling).

Hrm, this is a strange patch for sure. Coming at times when we all supp=
ose to
move to DT and get rid of such callbacks for drivers.

> This needs to be clarified first.  I think we could use this for now =
and
> later fix this properly (hopefully move it back to the ti-st driver).

Can the offending patch be reverted?
As I said to Felipe, I don't have any objections against this patch. It=
 fits
the purpose. But with the DT support (and removing callbacks to platfor=
m code)
you are going to have fair amount work.

--=20
P=C3=A9ter
