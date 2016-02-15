From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Date: Mon, 15 Feb 2016 11:25:38 -0600
Message-ID: <56C20A12.8080305@ti.com>
References: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
 <20160209220901.GC28102@localhost.localdomain> <56BA6530.4030102@ti.com>
 <20160212222347.GO19432@atomide.com>
 <CAGo_u6r8-LJBWWrew0fV50Q+JnCxDj9PD57+9NoDm5TqCWL=jw@mail.gmail.com>
 <20160212224129.GP19432@atomide.com> <56C153A3.3030508@ti.com>
 <56C1F3A1.4080709@ti.com> <56C1F92A.1020803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C1F92A.1020803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kumar Gala <galak@codeaurora.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

On 02/15/2016 10:13 AM, Keerthy wrote:
[...]
>>
>> This data is in the AM572x datasheet:
>> http://www.ti.com/lit/ds/symlink/am5728.pdf
>>
>> Table 5-3 in the current version contains the maximum junction
>> temperatures.
>>
>> this indicates that there are "Commercial" and "extended" -> we may
>> need to introduce just 2 dtsis -> am57xx-commercial and
>> am57xx-extended and reuse those based on the part on the board. just a
>> suggestion..
> 
> Or use the minimum of the 2 to be on the safer side if we have to deal 
> with one dtsi?

Why would we want to throttle earlier on customer platforms or other
boards using extended? at the very least -> if all upstream boards
have only commercial grade, then just introduce
am57xx-commercial-thermal.dtsi ..


-- 
Regards,
Nishanth Menon
