From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 11 May 2016 14:03:42 +0300
Message-ID: <5733118E.9070700@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-9-git-send-email-rogerq@ti.com>
 <20160511083421.GE16910@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160511083421.GE16910@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/05/16 11:34, Peter Chen wrote:
> On Mon, May 02, 2016 at 03:18:51PM +0300, Roger Quadros wrote:
>> +
>> +	if (config->otg_work)	/* custom otg_work ? */
>> +		INIT_WORK(&otg->work, config->otg_work);
>> +	else
>> +		INIT_WORK(&otg->work, usb_drd_work);
>> +
>> +	otg->wq = create_singlethread_workqueue("usb_otg");
> 
> Using create_freezable_workqueue like I suggested before.

Sorry that I missed this part. I'll fix it in v8.
> 
>> + */
>> +
>> +#ifndef __DRIVERS_USB_COMMON_USB_OTG_H
>> +#define __DRIVERS_USB_COMMON_USB_OTG_H
>> +
>> +/*
>> + *  A-DEVICE timing constants
>> + */
>> +
>> +/* Wait for VBUS Rise  */
>> +#define TA_WAIT_VRISE        (100)	/* a_wait_vrise: section 7.1.2
>> +					 * a_wait_vrise_tmr: section 7.4.5.1
>> +					 * TA_VBUS_RISE <= 100ms, section 4.4
>> +					 * Table 4-1: Electrical Characteristics
>> +					 * ->DC Electrical Timing
>> +					 */
>> +/* Wait for VBUS Fall  */
>> +#define TA_WAIT_VFALL        (1000)	/* a_wait_vfall: section 7.1.7
>> +					 * a_wait_vfall_tmr: section: 7.4.5.2
>> +					 */
>> +/* Wait for B-Connect */
>> +#define TA_WAIT_BCON         (10000)	/* a_wait_bcon: section 7.1.3
>> +					 * TA_WAIT_BCON: should be between 1100
>> +					 * and 30000 ms, section 5.5, Table 5-1
>> +					 */
>> +/* A-Idle to B-Disconnect */
>> +#define TA_AIDL_BDIS         (5000)	/* a_suspend min 200 ms, section 5.2.1
>> +					 * TA_AIDL_BDIS: section 5.5, Table 5-1
>> +					 */
>> +/* B-Idle to A-Disconnect */
>> +#define TA_BIDL_ADIS         (500)	/* TA_BIDL_ADIS: section 5.2.1
>> +					 * 500ms is used for B switch to host
>> +					 * for safe
>> +					 */
>> +
>> +/*
>> + * B-device timing constants
>> + */
>> +
>> +/* Data-Line Pulse Time*/
>> +#define TB_DATA_PLS          (10)	/* b_srp_init,continue 5~10ms
>> +					 * section:5.1.3
>> +					 */
>> +/* SRP Fail Time  */
>> +#define TB_SRP_FAIL          (6000)	/* b_srp_init,fail time 5~6s
>> +					 * section:5.1.6
>> +					 */
>> +/* A-SE0 to B-Reset  */
>> +#define TB_ASE0_BRST         (155)	/* minimum 155 ms, section:5.3.1 */
>> +/* SE0 Time Before SRP */
>> +#define TB_SE0_SRP           (1000)	/* b_idle,minimum 1s, section:5.1.2 */
>> +/* SSEND time before SRP */
>> +#define TB_SSEND_SRP         (1500)	/* minimum 1.5 sec, section:5.1.2 */
>> +
>> +#define TB_SESS_VLD          (1000)
> 
> Seems you agree to remove above definitions.

My bad, sorry.
> 
>>  
>>  	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>> index 85b8fb5..b094352 100644
>> --- a/include/linux/usb/otg.h
>> +++ b/include/linux/usb/otg.h
>> @@ -10,10 +10,55 @@
>>  #define __LINUX_USB_OTG_H
>>  
>>  #include <linux/phy/phy.h>
>> -#include <linux/usb/phy.h>
>> -#include <linux/usb/otg-fsm.h>
>> +#include <linux/device.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/ktime.h>
> 
> Above two headers are not needed
> 
OK.
