From: Kevin Hilman <khilman@mvista.com>
Subject: Re: MUSB: unreliable OTG detection in host mode
Date: Fri, 31 Aug 2007 17:29:03 -0700
Message-ID: <46D8B24F.3010409@mvista.com>
References: <46D8ACD1.8030101@mvista.com>
	<20070901002025.B8E79235120@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070901002025.B8E79235120@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
>> On 2430, I've noticed that using the driver built in OTG mode, the
>> detection of devices in host-mode is unreliable.
> 
> Unreliable in what way(s)?

Meaning it sometimes detects connected devices and sometimes not.
Sometimes a reboot and another try helps.  But with recent git it seems
to never detect devices.

> 
>> 	Building the driver in
>> only host mode doesn't have any problems with the same devices connected.
>>
>> I load the musb_hdrc module, then the g_zero module to initiate OTG
>> detection.
>>
>> If my board is connected as a gadget, this works just fine, but if my
>> board is the host and I have devices connected, the detection doesn't
>> work reliably.  In the past it seemed it would work most of the time,
>> but with the latest kernel, it doesn't seem to work at all.
> 
> This somewhat resembles a problem I've not tracked down, whereby
> the 2420 + TUSB6010-EVM, in OTG mode, seems to recieve garbage
> when reading descriptors from the high speed hub I usually like
> to connect as a root device.
>
> DaVinci didn't seem to have any such issues...
> 

I haven't tested DaVinci in OTG mode since on the EVM board I have, you
have to move a jumper to switch between the two.

Kevin
