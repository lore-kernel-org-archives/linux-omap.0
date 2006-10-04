From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Low level debug broken
Date: Wed, 04 Oct 2006 10:27:33 +0200
Message-ID: <45237075.9010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Greetings from murphy,

I enabled low level debug to debug broken OSK. I then 
reverted step by step git commits until I reached my last 
known working configuration ("Menelaus: Fix voltage values 
for VMEM"). And it stops as well at

...
<5>Kernel command line:...

Uups. Wonder!? ;)

I then disabled low level debug and my last known good 
config boots again. Mmmh, seems that low level debug is 
generally broken at more or less recent git (on OSK?).

Best regards

Dirk
