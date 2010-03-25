From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH 0/19] Cleanup- custom error codes
Date: Thu, 25 Mar 2010 15:58:14 -0500
Message-ID: <4BABCE66.7080304@ti.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBEB1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab0CYU6T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Mar 2010 16:58:19 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBEB1C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

Hebbar, Shivananda had written, on 03/25/2010 03:06 PM, the following:
> This RFC patch series tries to address the use of Linux standard error codes in dspbridge.
> 
> 1. 41 error codes are not currently used in bridge. Hence they can be removed.

> 
> 2. 19 error codes are mapped to Linux standard error codes. Patches 1 to 19 contains these changes.
> 
> 3. 7 error codes are used as base address to access the rest of error codes which can be removed. Some base addresses are removed as part of 1 but some are still kept as point 4 has dependency on these addresses.
> Ex: (Removed base address)
> /* FAILURE Codes: LDR */
> #define LDR_EBASE                   (DSP_COMP_EBASE + 0x100)
> 
> /* Insufficient memory to export class driver services. */
> #define LDR_E_NOMEMORY              (LDR_EBASE + 0x00)
> 
> /* Unable to find WMD file in system directory. */
> #define LDR_E_FILEUNABLETOOPEN      (LDR_EBASE + 0x01)
> 
> 4. For 46 error codes, couldn't find an exact match in Linux error code. This still needs to be worked out. This is not addressed in this patch series. (See attached text file for details)
lets keep this for stage 2 cleanup.
> 
> As for as OMX components concerned, they really don't care about the specific error codes. Hence no changes required for the OMX code.
> 
> Shivananda Hebbar (19)
> 
> DSPBRIDGE: Cleanup custom error code (DSP_EALREADYCONNECTED ->EISCONN) DSPBRIDGE: Cleanup custom error code (DSP_ECORRUPTFILE ->EBADF)
> DSPBRIDGE: Cleanup custom error code (DSP_EFILE ->ENOENT) 
> DSPBRIDGE: Cleanup custom error code (DSP_EHANDLE -> EFAULT) 
> DSPBRIDGE: Cleanup custom error code (DSP_EINVALIDARG -> EINVAL) 
> DSPBRIDGE: Cleanup custom error code (DSP_ENOMEM -> ENOMEM) 
> DSPBRIDGE: Cleanup custom error code (DSP_ENODETYPE -> EPERM)
> DSPBRIDGE: Cleanup custom error code (DSP_ENOTIMPL -> ENOSYS) 
> DSPBRIDGE: Cleanup custom error code (DSP_EFOPEN -> EBADF)
> DSPBRIDGE: Cleanup custom error code (DSP_EPOINTER -> EFAULT) 
> DSPBRIDGE: Cleanup custom error code (DSP_ERANGE -> EDOM)
> DSPBRIDGE: Cleanup custom error code (DSP_ESIZE -> EINVAL)
> DSPBRIDGE: Cleanup custom error code (DSP_ETIMEOUT -> ETIME)
> DSPBRIDGE: Cleanup custom error code (DSP_EVALUE -> EINVAL)
> DSPBRIDGE: Cleanup custom error code (DSP_EUUID -> ENOKEY)
> DSPBRIDGE: Cleanup custom error code (DSP_ENOTCONNECTED -> ENOTCONN)
> DSPBRIDGE: Cleanup custom error code (CHNL_E_CHANBUSY -> EALREADY)
> DSPBRIDGE: Cleanup custom error code (CHNL_E_CANCELLED -> ECANCELED)
> DSPBRIDGE: Cleanup custom error code (WMD_E_TIMEOUT -> ETIMEDOUT)
> 

 > Shivananda Hebbar (1)
 >
 > DSPBRIDGE: Cleanup- unused custom error codes
 >
 > Shivananda Hebbar (1)
 >
 > DSPBRIDGE: Cleanup- unused success codes

please add the remove unused codes into the series.
love the cleanup *but*:
arch/arm/plat-omap/include/dspbridge/dbdefs.h:typedef u32 dsp_status;
1) All usage of dsp_status should be changed to int
2) You should be using -Exxxx instead of Exxxxx in all the patches.

> 
> 
[...]

-- 
Regards,
Nishanth Menon
