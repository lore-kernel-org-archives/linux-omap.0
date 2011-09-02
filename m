From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 3/3] OMAP: omap_device: Add a method to build an
	omap_device from a DT node
Date: Fri, 2 Sep 2011 17:35:05 +0200
Message-ID: <4E60F7A9.8000903@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
	<1314037343-19783-4-git-send-email-b-cousson@ti.com>
	<87pqjj4yrs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87pqjj4yrs.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/2/2011 1:40 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Add a notifier called during device_add phase. If a of_node is present,
>> retrieve the hwmod entry in order to populate propely the omap_device
>> structure.
>> For the moment the resource from the device-tree are overloaded.
>> DT does not support named resource yet, and thus, most driver
>> will not work without that information.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> Nice, minor comment below...

[...]

>> +	case BUS_NOTIFY_DEL_DEVICE:
>> +		dev_dbg(&pdev->dev, "del_device\n");
>
> Need a delete/cleanup here.
>
> Looks like all all it needs to do is call omap_device_delete()?

Indeed, I was too lazy to add it.

Thanks,
Benoit
