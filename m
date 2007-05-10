From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: lcd driver for omap 850 - f-sample
Date: Thu, 10 May 2007 17:31:38 +0530
Message-ID: <2d51cbf80705100501r7b63033dl8ef770156fbfb57f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I have seen patches providing omap 850 f-sample core support and
lcd_p2.c was also tweaked a bit for some f-sample specific
initialization.
AFAIK, the core support patches have been intergrated in to the latest
kernel but the lcd driver specific stuff doesn't seem to be
integrated? Any specific reason or it just needs some more time?

Also, the build is broken if lcd_p2.c is included as it was pointed
out on this list couple of times before. It refers to non-existant
file omap_uwire.h. I have got an idea about how to fix this but if
some one  has already done this then any pointers will be useful. Any
patches/fixes floating around?
-- 

Regards,
Sandeep.
