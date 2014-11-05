From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 00/10] ARM: dts: TI: Add CAN support
Date: Wed, 5 Nov 2014 13:06:28 +0200
Message-ID: <545A04B4.1010508@ti.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com> <20141104155502.GS31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <20141104155502.GS31454@atomide.com>
Sender: linux-can-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/04/2014 05:55 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141104 02:50]:
>> Hi Tony,
>>
>> These patches add CAN support for am33xx, am43xx and dra7 platforms.
>> They must go in together with CAN driver RAMINIT Syscon support [1].
> 
> Can you make this series not depend on [1] for most part without
> breaking existing functionality?

I just checked that we haven't enabled DCAN on any of the boards
so we don't risk breaking anything even if these 2 series don't go in
together. 

> 
> Then we can do a single follow-up patch to enable things after [1]
> has been merged.
> 
> That would remove a dependency between driver changes and .dts changes.

Apart from patches 1, 3 and 8, that add the control module nodes the rest
pretty much depend on the driver DT binding changes.

I can send them separately if needed.

cheers,
-roger
