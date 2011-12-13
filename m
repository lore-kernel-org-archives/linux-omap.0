From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] fixes for twl4030-irq in mainline
Date: Tue, 13 Dec 2011 16:12:02 +0200
Message-ID: <CAMP44s1D+HXP_prHVwEztLCd1XJpnzukFeNKH_xEZrq06jEouA@mail.gmail.com>
References: <20111126201334.16080.85045.stgit@notabene.brown>
	<20111212173819.GT13952@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111212173819.GT13952@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: NeilBrown <neilb@suse.de>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Dec 12, 2011 at 7:38 PM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> On Sun, Nov 27, 2011 at 07:17:41AM +1100, NeilBrown wrote:
>> =C2=A0 The recent tidying up of twl4030-irq seems to have left it br=
oken.
>> At least it doesn't work for me on my gta04 (www.gta04.org). =C2=A0T=
he
>> first interrupt from the device freezes the whole system (by being
>> constantly delivered)
>>
>> The following 4 patches make it work for me and addresses some other
>> less critical issues like a typo in a comment :-)
>
> Thanks, I applied all 4 of them.

Did you apply them for 3.2 or 3.3? Without the first patch any system
that has a twl4030 chip will immediately hang on the first interrupt,
and many functions of twl4030 will just not work without the second
one.

--=20
=46elipe Contreras
