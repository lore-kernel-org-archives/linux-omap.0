From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHV3 2/4] OMAP: I2C: Remove the reset in the init path
Date: Thu, 21 Jul 2011 20:54:56 +0530
Message-ID: <4E2844C8.9010306@ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
	<1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
	<20110721135938.GC30943@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110721135938.GC30943@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: khilman@ti.com, balajitk@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 21 July 2011 07:29 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jul 21, 2011 at 07:22:59PM +0530, Shubhrajyoti D wrote:
>> The reset in the driver at init is not needed
>> anymore as the hwmod framework takes care of
>> reseting it.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> this is still doing two things:
>
> a. remove the reset from init path
> b. add and use ->device_reset() when needed.
Yes agree ,  will add it.
