From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: [PATCH] Disable old OMAP RTC driver if RTC_DRV_OMAP is enabled
Date: Mon, 4 Jun 2007 16:18:50 +0200
Message-ID: <fb249edb0706040718g14b6fc80r7d3c28204dbe53e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Make the old RTC driver depend on !RTC_DRV_OMAP to avoid conflicts. It
makes the new driver in rtc class take precedence over the old one.

What's the status of the OMAP RTC in Character Devices?  Is it going
to be removed? Enabling both drivers results in an Oops on boot due to
name collision.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
