From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: fix build breakage when CONFIG_OF is not set
Date: Wed, 8 Feb 2012 16:48:35 +0100
Message-ID: <4F329953.9010608@ti.com>
References: <1328698612-18661-1-git-send-email-coelho@ti.com>  <20120208105957.GB16334@legolas.emea.dhcp.ti.com>  <1328699077.20197.51.camel@cumari>  <CAM=Q2cvZWdUk-v4-EWUJzAf4br-4+tO2s3qS_dn4KhHp+mm2+g@mail.gmail.com> <1328700319.20197.54.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328700319.20197.54.camel@cumari>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Luca,

On 2/8/2012 12:25 PM, Luciano Coelho wrote:
> On Wed, 2012-02-08 at 16:42 +0530, Shubhrajyoti Datta wrote:
>> On Wed, Feb 8, 2012 at 4:34 PM, Luciano Coelho<coelho-l0cyMroinI0@public.gmane.org>  wrote:
>>> On Wed, 2012-02-08 at 12:59 +0200, Felipe Balbi wrote:
>>>> On Wed, Feb 08, 2012 at 12:56:52PM +0200, Luciano Coelho wrote:
>>>>> Since commit 6145197be6cc0583fa1a2f4ec1079d366137061e, building
>>>>
>>>> we generally like to see the commit subject here too. And adding the
>>>> abbreviated commit instead of the full sha1, wouldn't hurt either ;-)
>>>
>>> Ok, different practices. :)
>>
>> However  there was already a discurssion.
>> Anyways thanks for the patch.
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/69796
>>
>>
>>>
>>> I'll send v2.
>> I think there was already a fix for this.
>>
>> http://www.spinics.net/lists/linux-omap/msg63151.html
>>
>> Anyways thanks for the patch.
>
> Ah, okay.  Thanks for the info, I hadn't seen these.

Yeah, it looks like the OMAP fixes missed -rc2, but Tony sent the pull 
request [1].

Regards,
Benoit

[1] http://www.spinics.net/lists/linux-omap/msg63564.html
