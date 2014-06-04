From: =?ISO-8859-1?Q?Pascal_H=FCrst?= <pascal.huerst@gmail.com>
Subject: Re: [RFC PATCH 00/11] Embeddable Position Independent Executable
Date: Wed, 04 Jun 2014 15:36:22 +0200
Message-ID: <538F20D6.7030207@gmail.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com> <201310241009.12597.heiko@sntech.de> <1441820.DP5PYDOd2T@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441820.DP5PYDOd2T@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Russ Dill <Russ.Dill@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mans@mansr.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kbuild@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ru

On 22.04.2014 10:15, Heiko St=FCbner wrote:
> Hi Russ,
>
> Am Donnerstag, 24. Oktober 2013, 10:09:12 schrieb Heiko St=FCbner:
>> Am Dienstag, 17. September 2013, 14:43:26 schrieb Russ Dill:
>>> This patch adds support for and demonstrates the usage of an embedd=
ed
>>> position independent executable (PIE). The goal is to allow the use=
 of C
>>> code in situations where carefully written position independent ass=
embly
>>> was previously required.
>>
>> As suggested yesterday evening by Kevin Hilman, just adding my 2ct o=
f
>> support.
>>
>> This series looks exactly like the foundation I'll need at some poin=
t in the
>> (probably still distant) future to handle suspend on my Rockchip pla=
tform -
>> where like in your example stuff like putting the ram into selfrefre=
sh has
>> to be done by the os.
>
> just as it came up recently again for me and I couldn't find any newe=
r version,
> ist this series still on the table?

We have to maintain quite some patches, to keep pm working for our=20
project, so we're interested to get this mainline, too. Is someone=20
taking care of these issues? Or is there something i can do to help=20
getting this done?

regards
pascal
