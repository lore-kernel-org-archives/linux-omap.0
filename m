From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Exclusive use of OMAP3 TI ISP Resizer
Date: Tue, 3 Feb 2009 09:19:00 -0600
Message-ID: <A24693684029E5489D1D202277BE8944205B5FAC@dlee02.ent.ti.com>
References: <c6a924220902030706t54cf015aq802d897c584e17dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47423 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbZBCPTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 10:19:08 -0500
In-Reply-To: <c6a924220902030706t54cf015aq802d897c584e17dc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iqbal shareef <iqbalshareef.list@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nagalla, Hari" <hnagalla@ti.com>, "Lakhani, Amish" <amish@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of iqbal shareef
> Sent: Tuesday, February 03, 2009 9:07 AM
> To: linux-omap@vger.kernel.org
> Subject: Exclusive use of OMAP3 TI ISP Resizer
> 
> Hi
> 
> Current TI ISP implementation doesn't allow exclusive use of Resizer,
> I mean CCDC->Resizer.

Yeah, we haven't added that functionality yet to the driver because we didn't have the need with our customers yet. But as more people like you are demanding this, then a solution for implementing it shall be discussed.

> 
> Any specific reason why CCDC->Preview->Resizer path has been taken?
> Please share the background of this decision.

The reason on deciding about this ISP datapath is because we wanted to emphasize the use of the OMAP3 ISP, instead of the use of a sensor internal ISP.

> 
> My sensor gives only YUV data, but the Preview pipeline is happy only
> with RAW Bayer.
> Is this a hardware limitation?

Yeah, the ISP Preview module can only convert from 10-bit Bayer data to YCbCr 4:2:2 data (YUV).

> 
> Thanks
> Iqbal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

