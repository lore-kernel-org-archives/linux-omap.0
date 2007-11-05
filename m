From: "Girish" <girishsg@ti.com>
Subject: RE: [PATC 2/3]  silicon revision check for OMAP2/3
Date: Mon, 5 Nov 2007 17:29:47 +0530
Message-ID: <012101c81fa3$5d253930$6a8918ac@ent.ti.com>
References: <20071102155706.GA24982@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071102155706.GA24982@intune.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Daniel Stone' <daniel.stone@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>> +get_device_type() \
>> +		((system_rev & 0x700) >> 8)
>
>Nice work on defining the get_device_type() macro, but why not 
>use it above, so you have:
>#define is_device_type_test() (get_device_type == DEVICE_TYPE_TEST)

Thanks, all your comments have been incorporated.

Regards,
girish
