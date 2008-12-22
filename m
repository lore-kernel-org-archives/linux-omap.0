From: "pramod gurav" <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C1 controller timed out issue
Date: Mon, 22 Dec 2008 10:44:22 +0530
Message-ID: <f502236f0812212114p4b20e81br52d9031c4673f886@mail.gmail.com>
References: <f502236f0812200204h1ef1df01sf79243e6e276074d@mail.gmail.com>
	 <20081220131321.GB10866@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081220131321.GB10866@frodo>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,
I am using current linux-omap git sources. Can you please post the patch to fix
this timeout issue.

On Sat, Dec 20, 2008 at 7:39 PM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote:
> On Sat, Dec 20, 2008 at 03:34:00PM +0530, pramod gurav wrote:
>> Hi,
>> I am working on OMAP3430 board. The kernel is linux-omap-2.6.
>> The twl5030 module is sitting on i2c1.
>> I often come across a error saying
>>
>> i2c_omap i2c_omap.1: controller timed out
>> i2c_omap i2c_omap.1: controller timed out
>>
>> This is all what appears in logs when i2c1 times out and all the
>> other slave devices on i2c1 stop responding. Other i2c busses(2)
>> work properly. if try to reboot the I2C fails to respnd in u-boot also
>> saying
>>
>> timed out in wait_for_pin: I2C_STAT=0
>> I2C read failed
>> timed out in wait_for_pin: I2C_STAT=0
>> I2C read failed
>> timed out in wait_for_pin: I2C_STAT=0
>> I2C read failed
>>
>> I have to to do hard reset to progress with the boot.
>>
>> I gone through the changes happened to i2-omap driver in between
>> and tried applying the patches manually.
>> The problem still persists.
>> May be I am missing some more changes.
>>
>> The i2-omap.c source is attached herewith this mail.
>> Somebody please suggest me on this issue if this has been seen as
>> a issue and if fixed.
>
> Are you using current linux-omap from git ? This problem is long gone.
>
> --
> balbi
>
