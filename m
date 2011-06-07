From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Tue, 07 Jun 2011 09:04:09 -0700
Message-ID: <87hb81r5l2.fsf@ti.com>
References: <1307392698-21170-1-git-send-email-ccross@android.com>
	<87boyav99n.fsf@ti.com>
	<BANLkTik-UK9EPsnUkQeih+Zf_9py-X2Q0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTik-UK9EPsnUkQeih+Zf_9py-X2Q0A@mail.gmail.com> (Grant
	Likely's message of "Mon, 6 Jun 2011 19:06:36 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Colin Cross <ccross@android.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, tarun.kanti@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Mon, Jun 6, 2011 at 5:18 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Hi Colin,
>>
>> Colin Cross <ccross@android.com> writes:
>>
>>> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
>>> causing only the last bit set to take effect, resulting in lost
>>> wakeups when the GPIO controller is in idle.
>>>
>>> Replace direct writes to IRQWAKEN with MOD_REG_BIT calls to
>>> perform a read-modify-write on the register.
>>>
>>> Signed-off-by: Colin Cross <ccross@android.com>
>>
>> Thanks, I'll queue these both for Grant for the 3.0-rc fixes along w=
ith
>> another GPIO fix for a section mismatch I have queued.
>>
>> Minor: now that this driver has moved to drivers, I changed the subj=
ect
>> prefixes slightly. =C2=A0They now read:
>>
>> GPIO: OMAP: fix setting IRQWAKEN bits for OMAP4
>> GPIO: OMAP: add locking around calls to _set_gpio_triggering
>
> If you're collecting fixes for Linus anyway, go ahead and add my a-b
> line and include these two to send on to Linus
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> Or, if they are only gpio fixes, then I'd also be happy to get a git
> pull req for the changes.  :-)
>

I have a GPIO-only queue, so I'll have a pull req for you today.

Kevin
