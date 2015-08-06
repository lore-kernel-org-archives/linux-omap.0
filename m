From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/8] rtc: omap: Add external clock enabling support
Date: Thu, 6 Aug 2015 11:47:36 +0200
Message-ID: <20150806094736.GM3486@piout.net>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-4-git-send-email-j-keerthy@ti.com>
 <20150805111316.GI16878@atomide.com>
 <20150805114119.GF3486@piout.net>
 <20150805114357.GG3486@piout.net>
 <55C32AB6.7090509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C32AB6.7090509-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/08/2015 at 12:36:54 +0300, Grygorii Strashko wrote :
> Pls, correct me if I'm not right. Is below what you propose?
> 
> Doard dts:
> / {
>  rtc_32k_ext_clk: rtc_osc_xi_clkin32_ext {
> 	#clock-cells = <0>;
> 	compatible = "fixed-clock";
> 	clock-frequency = <32000>;
>   	clock-output-names = "rtc_osc_xi_clkin32";
>   };
> }
> 
>  &rtc {
>  	status = "okay";
> 	clocks = <&sys_32k_ck>, <&rtc_32k_ext_clk>;
> 	[optional] clock-names = "int-clk", "ext-clk";
>  };
> 
> Driver:
> 1) clk0 is mandatory, internal clock source
> 2) clk1 is optional, external clock source, so
> if present - RTC driver can switch to use ext clock source
> 

Absolutely!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
