From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/4] OMAP serial device tree support
Date: Mon, 28 Nov 2011 11:36:56 +0530
Message-ID: <4ED32500.5060908@ti.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com> <20111127033642.GA28378@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20111127033642.GA28378@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sunday 27 November 2011 09:06 AM, Greg KH wrote:
> On Tue, Nov 22, 2011 at 07:14:12PM +0530, Rajendra Nayak wrote:
>> v2 is based on the latest omap-serial runtime patches, which
>> can be found here[1]
>>
>> The series passes minimal data that allows serial console
>> boot, with UART's initialised from device tree.
>> However some of low power support for UART and remote
>> wakeup needs more work.
>> Boot tested on OMAP4 panda and OMAP4 sdp boards.
>>
>> Patches can be found here..
>> git://gitorious.org/omap-pm/linux.git for-dt/serial
>
> What tree are these going to go through, some device tree one, or do you
> want me to take the serial driver patches?

Hi Greg,

These patches have a dependency on the omap-serial runtime series.
So once that makes it in, through the serial driver tree, and once we
have the necessary Acks from the Device Tree maintainers on the relevant
patches from this series, these could go through the serial driver tree
as well.

thanks,
Rajendra

>
> thanks,
>
> greg k-h

