From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] arm: mach-omap2: gpmc: ignore non-available nodes
Date: Wed, 2 Jul 2014 05:33:37 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF8D44@DBDE04.ent.ti.com>
References: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
 <20140626163707.GA26836@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140626163707.GA26836@arch.cereza>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, =?iso-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

>From: Ezequiel Garc=EDa [mailto:ezequiel@vanguardiasur.com.ar]
>>On 26 Jun 12:02 PM, Guido Mart=EDnez wrote:
>> Currently, child nodes of the gpmc node are iterated and probed
>> regardless of their 'status' property. This means adding 'status =3D
>> "disabled";' has no effect.
>>
>> This patch changes the iteration to only probe nodes marked as
>> available.
>>
>> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
>
>Just a nit: the commit title doesn't match the recent commits. If you
>run "git log" on this file, you'll find the pattern should be somethin=
g
>like:
>
>"ARM: OMAP2+: GPMC should only probe enabled devices"
>
>Other than this, the patch looks correct.
>
Yes, plz keep patch title consistent as in other gpmc.c patches.
And thanks for this fix.

Tested-by: Pekon Gupta <pekon@ti.com>

with regards, pekon
