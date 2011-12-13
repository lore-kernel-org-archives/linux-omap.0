From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Interrupt issue in twl4030_keypad
Date: Tue, 13 Dec 2011 15:15:41 +0200
Message-ID: <CANOLnON4bEx-g+WhfJ9qQTmeDOMNoFnbF6CnkO9r33W14PnuJQ@mail.gmail.com>
References: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
	<20111212191241.GC3408@legolas.emea.dhcp.ti.com>
	<CAMP44s1X_KDbzu2CLO0fzM=7rozTQ4K10AtQkc0Ww8uDg8Z-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <CAMP44s1X_KDbzu2CLO0fzM=7rozTQ4K10AtQkc0Ww8uDg8Z-mw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 12, 2011 at 10:55 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Dec 12, 2011 at 9:12 PM, Felipe Balbi <balbi@ti.com> wrote:
>> On Mon, Dec 12, 2011 at 08:30:49PM +0200, Felipe Contreras wrote:
>>> The short version is this: either we revert this patch[1], or we ap=
ply
>>> this patch series[2], as well as its essential fixes[3].
>>>
>>> The long version is this. There's a synchronization issue with the
>>> current keypad driver and twl core; the irq is marked as handled ev=
en
>>> though the thread that is supposed to handle it hasn't run yet, and
>>> since it's clear-on-read, and it hasn't been read, it's detected
>>> again, so they keypad driver receives two interrupt callbacks inste=
ad
>>> of one, and in the second one reads nothing from the i2c register, =
so
>>> a key release is assumed. This makes key-presses as simple as shift=
+a
>>> impossible.
>>>
>>> In other words, it's totally unreliable. This might not be isolated=
 to
>>> the keypard driver, but other "nested" interrupts from twl core tha=
t
>>> started using request_threaded_irq prematurely (before it was
>>> supported by the twl core). But at least I haven't tried those.
>>>
>>> This patch was applied on 2.6.33, which means all versions before 3=
=2E2
>>> are affected, including 3.1.
>>>
>>> What do you think about fixing this on stable kernels?
>>
>> I believe Samuel has already applied those to the MFD tree.
>
> Yeap, I think Linus' tree is going to be fine (3.2), but I'm trying t=
o
> find out what to do with previous kernels: as in, what should be done
> for stable trees.

I only see this in his -next branch, so 3.2 is still affected.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
