From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] Revert "ARM: RX-51: Enable isp1704 power on/off"
Date: Mon, 12 Dec 2011 09:09:20 +0200
Message-ID: <4EE5A8A0.2010206@bitmer.com>
References: <1323105820-25946-1-git-send-email-felipe.contreras@nokia.com>	<1323105820-25946-3-git-send-email-felipe.contreras@nokia.com>	<CAMP44s3Szzm9iXxghXfNCBjKyUw-nRrG1aEeweKnRCidaxmxEA@mail.gmail.com>	<4EDF5231.6080309@bitmer.com> <CAMP44s0a6hcORZn8wDxHUJKxs=wjAmkhRfiT9kEA_MoDYeAmfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMP44s0a6hcORZn8wDxHUJKxs=wjAmkhRfiT9kEA_MoDYeAmfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Heikki Krogerus <heikki.krogerus@nokia.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/07/2011 08:42 PM, Felipe Contreras wrote:
> On Wed, Dec 7, 2011 at 1:46 PM, Jarkko Nikula <jarkko.nikula@bitmer.com> wrote:
>> On 12/05/2011 07:31 PM, Felipe Contreras wrote:
>>> Should probably have CC'ed linux-omap.
>>>
>>> On Mon, Dec 5, 2011 at 7:23 PM, Felipe Contreras
>>> <felipe.contreras@nokia.com>  wrote:
>>>> From: Felipe Contreras<felipe.contreras@gmail.com>
>>>>
>>>> This reverts commit 10299e2e4e3ed3b16503d4e04edd48b33083f4e2.
>>>>
>>>> This seems to break USB networking stuff.
>>>>
>> I don't think revert is needed since CONFIG_CHARGER_ISP1704=y should make it
>> working. Although I don't know do we really need to drive the ISP1704 into
>> reset in board-rx51-peripherals.c? Would it be better to leave gpio state as
>> it was set by the bootloader and let the driver to do reset sequence if
>> needed?
>>
>> http://marc.info/?l=linux-omap&m=130795363204884&w=2
> Nope, that's actually worst:
>
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab001
> Internal error: : 1028 [#1]
> Modules linked in:
Indeed yes. I checked that in 3.0 it still works but not in 3.1 so some
non isp1704_charger change has broke it as there hasn't been changes on it.

-- 
Jarkko
