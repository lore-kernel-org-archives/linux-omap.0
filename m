From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: OMAP5+: separate the cpu thermal zone definition
 from omap4
Date: Mon, 23 Mar 2015 12:00:53 -0500
Message-ID: <551046C5.1080901@ti.com>
References: <1426880861-9266-1-git-send-email-nm@ti.com> <1426880861-9266-2-git-send-email-nm@ti.com> <20150320215402.GB7346@developer.amazonguestwifi.org> <550FE807.6020107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550FE807.6020107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 03/23/2015 05:16 AM, Tero Kristo wrote:
> On 03/20/2015 11:54 PM, Eduardo Valentin wrote:
>> On Fri, Mar 20, 2015 at 02:47:39PM -0500, Nishanth Menon wrote:
>>> From: Tero Kristo <t-kristo@ti.com>

[...]

>> Can't we simple change the polling value for the omap5 case and reuse
>> the omap4 file?
> 
> Hmm yea, I posted a patch like this before for o5 and it was queued 
> already. See:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.omap/123729
> 
> The dra7 part was missing from this set though, so patches 2/3 do not 
> directly work with that one and will require some changes similar to the 
> linked omap4 one.

OK. will do that and as part of that, I will squash up patch 1 and 2
Since it is needed only when we introduce DRA7 thermal description -
Apologies on missing the O5 patch.


-- 
Regards,
Nishanth Menon
