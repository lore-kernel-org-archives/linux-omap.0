From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: [RFC] onenand detect logic
Date: Fri, 24 Aug 2007 15:29:54 -0500
Message-ID: <46CF3FC2.3010203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Linux OMAP List <linux-omap-open-source@linux.omap.com>, rohitkc@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Folks,
as a disclaimer, the following discussion is entirely a thought
experiment ;)

While discussing with Rohit C on supporting a different onenand on git
kernel, he enlightened me that the GPMC tracking and detecting onenand
CS based address is flaky.
Current Logic (with a highly deserving HACK alert comment) does this:
for each CS(){
   if (CONFIG_7 reg  ==0x20000000)
	then assume it is onenand.
}

Here is a alternative proposal (majority from Rohit):

for each CS(){
	if (configured as a NOR type memory){
		write 0x90 to CONFIG_7 0x0 offset /* 0x90 0r 0x98 CFI command will
ensure that the memory is in non-read state, but in onenand it is a
readonly location */
		read  manu id and device id from onenand regs offsets from CONFIG_7
		if matched as that for onenand, select same
	}
}
Caveat: does not detect 2 onenands..

Question: Any better way of doing this dynamically and a bit more elegantly?

Regards,
Nishanth Menon
		
