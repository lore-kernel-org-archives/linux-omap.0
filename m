From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for SW babble Control
Date: Tue, 13 May 2014 14:20:31 +0200
Message-ID: <53720E0F.3070008@gmail.com>
References: <1399969905-3509-1-git-send-email-george.cherian@ti.com> <5371EA01.3080307@gmail.com> <537208A9.4020507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <537208A9.4020507@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

On 05/13/2014 01:57 PM, George Cherian wrote:
> On 5/13/2014 3:16 PM, Daniel Mack wrote:
>> On 05/13/2014 10:31 AM, George Cherian wrote:
>>> Series add support for SW babble control logic found in
>>> new silicon versions of AM335x. Runtime differentiation of
>>> silicon version is done by checking the BABBLE_CTL register.
>>> For newer silicon the register default value read is 0x4 and
>>> for older versions its 0x0.
>> I tested this on a AM33xx platform and don't see any regression at
>> least. This hardware has MUSB_BABBLE_CTL == MUSB_BABBLE_RCV_DISABLE.
>> Anything particular you want me to test as well?
> Are you seeing a wrapper restart done always or does it continue with a 
> restart
> after the babble condition?

MUSB_BABBLE_CTL == MUSB_BABBLE_RCV_DISABLE, so sw_babble_control() is
called from dsps_musb_reset(). However, MUSB_BABBLE_CTL still returns
0x04 (MUSB_BABBLE_RCV_DISABLE) inside that function, which means
(babble_ctl & MUSB_BABBLE_STUCK_J) is false, and hence
sw_babble_control() returns 1. Consequently, the glue is fully reset in
this case. Does this help?

FWIW, this is the output of dsps_musb_reset() with dev_dbg() enabled:

[   54.066124] CAUTION: musb: Babble Interrupt Occurred
[   54.071856] usb 1-1: USB disconnect, device number 8
[   54.159495] musb-hdrc musb-hdrc.0.auto: babble: MUSB_BABBLE_CTL value 4
[   54.166446] musb-hdrc musb-hdrc.0.auto: STUCK_J is reset


I only have one exact USB device to reproduce the babble condition, so I
guess this is all I can do for now.


Thanks,
Daniel
