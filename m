From: "b8944028" <b8944028@stmail.cgu.edu.tw>
Subject: [omap5912] music is broken after adjusting dpll clock ..?
Date: Wed, 14 Jun 2006 21:04:25 +0800
Message-ID: <20060614124709.M46654@stmail.cgu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=big5
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

  I use madplay on omap5912 to play mp3 music. The mp3 music can be play
smoothly. But if I adjust dpll clock, the music become rugged. Is there any
addition setting of clock rate ? My code to adjust is :

//to adjust as 192 MHz
*dpll &= ~(0x7f) << 5;
*dpll |= (0x40 << 5);

//to adjust as 96 MHz
*dpll &= ~(0x7f) << 5;
*dpll |= (0x41 << 5);

In fact, I want to develop a dynamic clock scaling system, but the music
become rugged when I change dpll clock.

How to adjust clock correctly and not to affect music ? 

regards

D.G.Lin
