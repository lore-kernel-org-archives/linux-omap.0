From: =?UTF-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01
 LCD displays
Date: Tue, 21 Aug 2012 10:29:14 -0400
Message-ID: <50339B3A.3020005@8d.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>  <1345023063.3494.20.camel@deskari> <502BBFBB.6090303@8d.com> <1345546189.4085.52.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:34444 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165Ab2HUO3Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 10:29:16 -0400
In-Reply-To: <1345546189.4085.52.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On 21/08/12 06:49 AM, Tomi Valkeinen wrote:
> On Wed, 2012-08-15 at 11:26 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:
>=20
>>> +
>>> +	/* ChiMei G121S1-L01 */
>>> +	{
>>> +		{
>>
>> ...
>>
>>> +			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
>>> +			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
>>> +			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
>>> +			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
>>> +			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
>>
>> Actually those 3 panels only use the DE signal. The hsync/vsync sign=
als
>> are not used and on our system we mux them out to make sure they are
>> kept low as recommended in the panel datasheets.
>>
>> Since vsync/hsync are not used, I think the vsync_level, hsync_level=
 and
>> sync_pclk_edge entries could be removed. Otherwise the updated patch
>> works fine as is.
>=20
> Okay. How do panels like that work? How can they know where a new fra=
me
> starts?

By DE being inactive for a different number of pixel clock cycles durin=
g
the vertical and horizontal blanking periods.


> Actually, I now googled for those panels, and they are all LVDS panel=
s,
> not DPI panels. So the patch doesn't look correct at all.
>=20
> Do you have a DPI-to-LVDS converter chip on your board?

Yes, we do. Depending on the board, we use a SN75LVDS83B or a SN65LVDS8=
4.

The reason for using this approach was that the panels covered by
this patch seemed not to be compatible with Flatlink 3G, which meant
driving them directly from the AM35xx SDI serial interface was not poss=
ible.
We unfortunately do not get to select which LVDS deserializer is
used at the panel side..

Best regards,
Rapha=C3=ABl Ass=C3=A9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
