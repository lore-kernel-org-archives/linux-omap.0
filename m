From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Undefined usb_disconnect
Date: Sun, 28 May 2006 15:21:28 +0200
Message-ID: <4479A3D8.5070507@gmail.com>
References: <4452384E.7080409@gmail.com>
	<20060505110852.66e6f39d.Hiroshi.DOYU@nokia.com>
	<4477F3E1.4000301@gmail.com>
	<200605270843.54940.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605270843.54940.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> On Friday 26 May 2006 11:38 pm, Dirk Behme wrote:
> 
>>Hi,
>>
>>with recent git I still get
>>
>>WARNING: "usb_disconnect" [drivers/usb/host/ohci-hcd.ko] 
>>undefined!
> 
> 
> Try the attached patch instead ... it fixes some other glitches
> in the OMAP bus glue, as well as those.

Okay, hanks for the patch! I think we should apply it until

http://linux.omap.com/pipermail/linux-omap-open-source/2006-May/007071.html

is reworked and ready for inclusion.

Thanks

Dirk
