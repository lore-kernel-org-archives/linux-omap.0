From: Patrick <kpa_info@yahoo.fr>
Subject: OMAP4 TWL6030 uv_to_vsel warning
Date: Tue, 03 Apr 2012 16:27:57 +0200
Message-ID: <4F7B08ED.1060104@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm1.bullet.mail.ukl.yahoo.com ([217.146.183.218]:42403 "HELO
	nm1.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754353Ab2DCOeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 10:34:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear mailing-list,

I am working with the 3.3 kernel on an OMAP4430 with a TWL6030.
I have many warning like the following:

twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660

I would like to clarify this and eventually "remove" this warning.
I have checked omap_twl.c file. It seems that twl6030_uv_to_vsel() 
function have a special branch when uv is equal to 1350000 uV and when 
bigger than 1350000 uV it print the error message.

On the same file I could see that on_volt (and the onlp_volt) are set by 
default to 1375000 uV for the OMAP4.

On the datasheet of the TWL6030 I could see that the level is 1367400 
uV. 1350000 nor than 1375000 are invalid level.

Don't you thin that 1375000 and 1350000 should be the same value ?
If we could change the default on_volt (and the onlp_volt) for the OMAP4 
to 1350000 the Warning message will then be removed, and the effective 
level on the TWL6030 will still stay to 1367400 uV.

Any comment are welcome !

Patrick
