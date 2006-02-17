From: =?big5?B?qkykcKq0?= <subsun.ece94g@nctu.edu.tw>
Subject: A problem about the uart3 of OMAP osk5912
Date: Fri, 17 Feb 2006 16:27:58 +0800
Message-ID: <20060217163457.9B78586CF0@mailreg.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

Hi there,

I have a problem about the uart3 of OMAP osk5912. The fact is that osk5912
don't have a second substantial uart port. We tried to send a echo signal to
/dev/ttyS02(which is a character device node with the major number 4 and
minor number 65 we made), but there was no voltage change on the TX of
uart3. Can you tell me how to control the second uart of osk5912 under OS?
Further more, can you tell me how to use the USB serial converter? We were
using the GMUS-03 with chipset prolific, although the required convert is
Elecom's US-SGT.

 

Regards,

May

 
