From: Mike Chan <mike@android.com>
Subject: Re: [PATCH 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
Date: Thu, 22 Apr 2010 16:22:50 -0700
Message-ID: <k2w8bb80c381004221622tf623adaw15d72d04a5db5c7e@mail.gmail.com>
References: <1271295665-26187-1-git-send-email-mike@android.com>
	 <87aasw5oyx.fsf@deeprootsystems.com>
	 <s2y8bb80c381004211750hd8d62be8hfa0bead1dbfa8d2b@mail.gmail.com>
	 <87wrvzxgok.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87wrvzxgok.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 22, 2010 at 3:31 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> On Wed, Apr 21, 2010 at 5:07 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Mike Chan <mike@android.com> writes:
>>>
>>>> IO events can also come from GPIO modules, which reside in the PER=
 domain.
>>>> It is possible for the PER to enter RET while CORE is still in ON.
>>>> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will no=
t
>>>> wakeup in this case, unless we enable it.
>>>>
>>>> Signed-off-by: Mike Chan <mike@android.com>
>>>
>>> Hi Mike,
>>>
>>> I'm a little puzzled on this one. =A0My understanding is that the I=
O pad
>>> is only armed when CORE is in RET or OFF.
>>>
>>
>> The issue we are seeing is when the device is active but idle, if CO=
RE
>> is ON and PER is in RET and the omap is sitting in swfi. If the user
>> presses a keypad button, IO pad doesn't wake us out of idle. Setting=
 a
>> wakeup if PER or CORE goes into RET solve this.
>>
>>> I need to dig a little more in the TRM on this one to clarify.
>>>
>>
>> I was looking at 4.11.2.2 I/O Wake-Up Mechanism (pg 421)
>>
>
> Yeah, that's the right place.
>
> After a little more digging and asking around, this looks like a good
> fix, but there's a minor problem with the implementation:
>
> In the section of the TRM you referenced the following sentence is
> hiding:
>
> =A0"Software must wait for the I/O daisy chain to complete before it
> =A0 transitions the PER domain to a nonfunctional state."
>
> In the proposed patch, it's likely that PER could transition to
> INACTIVE/RET/OFF before the IO wakeups are enabled. =A0For example, i=
f
> nothing in PER is active except UART3, then PER will transition to an
> idle state right after omap_uart_prepare_idle(2), which is before
> the IO wakeups are currently enabled.
>
> To be perfectly safe, the IO wakeups should be enabled before PER is
> allowed to transition.
>

Sounds good, I'll spin a v2 and send it out.

-- Mike

> Kevin
>
>
>
>
>
>
