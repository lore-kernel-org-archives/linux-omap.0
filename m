From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Mon, 11 Jan 2016 08:44:59 -0600
Message-ID: <5693BFEB.3020500@ti.com>
References: <20160109230709.GA30551@amd> <20160110080621.GA3929@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160110080621.GA3929@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
Cc: a.hajda@samsung.com, giometti@linux.it
List-Id: linux-omap@vger.kernel.org

On 01/10/2016 02:06 AM, Pavel Machek wrote:
> Hi!
>
>> Did /sys/class/power_supply/bq27200-0/capacity change meaning between
>> 4.1 and 4.4?
>>
>> It used to report battery capacity remaining in percent.
>>
>> Not sure what it reports now, but ain't in percent....
>
>> The patch does not compile, but I should be sleeping, not trying to
>> understand crazy code. Whoever wrote it, please fix it. Maybe you can
>> just do
>
> ...and more crazy code :-(.
>
>          cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> 		if ((cache.flags & 0xff) == 0xff)
> 		                cache.flags = -1; /* read error */
> 				        /* WTF? bq27xxx returns -ERRNO
>          on error, we mask some bits off it, and then make it -1... */
> 	

This is probably left over from when the driver was 1wire only, which seems
to fail by just reading back all ones. Not sure why the -1 though?

>
> ...and one crazy optimalization...
>
>          if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
> 	                di->cache = cache;
>

Hmmm, I think the lines above it:

	if (di->cache.capacity != cache.capacity)
		power_supply_changed(di->bat);

were at one point rolled into this as so:

	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0) {
		di->cache = cache;
		power_supply_changed(di->bat);
	}

Otherwise that isn't an optimization, it probably takes more
time comparing than just doing the copy every time...

> ...are we playing obfuscated C code contest, yet?
>
>          case POWER_SUPPLY_PROP_PRESENT:
> 	                val->intval = di->cache.flags < 0 ? 0 : 1;
>
> ...to decidegree C?
>                  if (ret == 0)
> 		   	        pval->intval -= 2731; /* convert decidegree k to c */
>
> as read takes enum, make it enum like this?
> static inline int bq27xxx_read(struct bq27xxx_device_info *di, enum bq27xxx_reg_index reg_index,
> 		                         bool single)
> 					

ACK

>
> 									Pavel
>
