From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP3: PM: (re)init for every transfer to support
	off-mode
Date: Thu, 12 Nov 2009 11:29:49 -0800
Message-ID: <636c5030911121129h46f042bav7f0ed23c625b54dd@mail.gmail.com>
References: <1248217743-24330-1-git-send-email-khilman@deeprootsystems.com>
	 <20090729234308.GA8850@fluff.org.uk>
	 <4A7760A4.3080109@deeprootsystems.com>
	 <636c5030909301506p7da5f016m5148ce6cd279e704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <636c5030909301506p7da5f016m5148ce6cd279e704-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 30, 2009 at 2:06 PM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> On Mon, Aug 3, 2009 at 3:11 PM, Kevin Hilman
> <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
>> Ben Dooks wrote:
>>>
>>> On Tue, Jul 21, 2009 at 04:09:03PM -0700, Kevin Hilman wrote:
>>>>
>>>> From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
>>>>
>>>> Because of OMAP off-mode, powerdomain can go off when I2C is idle.
>>>> Save enough state, and do a re-init for each transfer.
>>>>
>>>> Additional save/restore state added by Jagadeesh Bhaskar Pakaravoo=
r
>>>> (SYSC_REG) and Aaro Koskinen (wakeup sources.)
>>>>
>>>> Also, The OMAP3430 TRM states:
>>>>
>>>> "During active mode (I2Ci.I2C_CON[15] I2C_EN bit is set to 1), mak=
e no
>>>> changes to the I2Ci.I2C_SCLL and I2Ci.I2C_SCLH registers. =A0Chang=
es may
>>>> result in unpredictable behavior."
>>>>
>>>> Hence, the I2C_EN bit should be clearer when modifying these
>>>> registers. Please note that clearing the entire I2C_CON register t=
o
>>>> disable the I2C module is safe, because the I2C_CON register is
>>>> re-configured for each transfer.
>>>
>>> should this be applied as a bugfix, or kept for next merge window?
>>
>> next merge window is fine.
>>
>
> Ben,
>
> It doesn't look like this made it in during the 2.6.32 merge window.
> Can you queue it for the -rc series?
>

ping
