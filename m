From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 06/10] I2C: OMAP: Fix the crash in i2c remove
Date: Thu, 26 Apr 2012 12:13:24 +0530
Message-ID: <4F98EE8C.3070001@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-7-git-send-email-shubhrajyoti@ti.com>
 <20120423164944.GE27321@pengutronix.de> <4F96ED77.9070503@ti.com>
 <20120424181806.GF9007@pengutronix.de> <4F98EB03.8060903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F98EB03.8060903@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 26 April 2012 11:58 AM, Shubhrajyoti wrote:
> On Tuesday 24 April 2012 11:48 PM, Wolfram Sang wrote:
>> On Tue, Apr 24, 2012 at 11:44:15PM +0530, Shubhrajyoti wrote:
>>> On Monday 23 April 2012 10:19 PM, Wolfram Sang wrote:
>>>>>     [  154.901153] Exception stack(0xdf9b9fb0 to 0xdf9b9ff8)
>>>>>>     [  154.907104] 9fa0:                                     beaf1f0=
4 4006be00 0000000f 0000000c
>>>>>>     [  154.915710] 9fc0: 4006c000 00000000 00008034 ffffff40 0000000=
7 00000000 00000000 0007b8d7
>>>>>>     [  154.916778] 9fe0: 00000000 beaf1b68 0000d23c 4005baf0 8000001=
0 ffffffff
>>>>>>     [  154.931335]  r6:ffffffff r5:80000010 r4:4005baf0 r3:beaf1f04
>>>>>>     [  154.937316] ---[ end trace 1b75b31a2719ed21 ]--
>>>>>>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>>>> Is this really the correct solution? I do wonder that every driver usi=
ng
>>>> runtime PM should enable the clocks on their own. That should be done =
by
>>>> the core, =

>>> By core you don't mean the i2c core but the pm layer right?
>> Yes.
>>
>>>> I'd say; it is not unusual that drivers need to write to
>>>> registers in remove(). If it is correct, can I get some acks?
>>> I did see the crash.
>> That was never a doubt. With "correct" I meant "correct solution".
>>
>>> Will wait for the pm experts to comment.
> As far as I know I don=92t think that the pm layer doesn't enable the clo=
cks
> for the drivers on remove. Maybe Kevin or Rajendra can comment better.
typo what i meant was

As far as I know the pm layer doesn't enable the clocks
for the drivers on remove. Maybe Kevin or Rajendra can comment better.

thanks,
>
>
