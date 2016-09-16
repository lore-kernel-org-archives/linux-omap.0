From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: am335x-evm: Add blue-and-red-wiring
 -property to lcdc node
Date: Fri, 16 Sep 2016 17:17:21 -0500
Message-ID: <a0e00898-80fb-8242-aafb-6e4d3f650345@ti.com>
References: <cover.1474025756.git.jsarha@ti.com>
 <34893e286d16c281098063d2a4fec985acbf8818.1474025756.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <34893e286d16c281098063d2a4fec985acbf8818.1474025756.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/16/2016 06:50 AM, Jyri Sarha wrote:
[..]
> +	blue-and-red-wiring = "crossed";

Dumb question: Why is this a Linux generic property - does it make 
sense to have "blue-and-red-wiring" as a Linux generic property? I 
mean, it reminds me little of those movies "cut the blue or red wire 
to diffuse the bomb" ;)

"The am335x-evm has blue and red wires crossed to get 24-bit RGB (and 
16-bit BGR". I mean, there has to be some sort of better description 
specific to lcdc if some product used yellow and green wires for the 
same signals crossed?

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
