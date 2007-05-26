From: karthik <skarthikeyan_17@yahoo.com>
Subject: jffs2 on osk5912
Date: Sat, 26 May 2007 13:06:55 -0700 (PDT)
Message-ID: <913120.21031.qm@web51401.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi all,

i tried mounting a jffs2 filesystem as root.

i get the following the error a lot of times until no space is left (memory free is zero) in the system.

 failed immediately: -EROFS. Is the sector locked?

after this `mkdir` says there is no space.

what's wrong?  The configuration i have chosen is exactly as given in oskfordummies site.


----------
 
And when i give the following bootargs linux asks does dhcp request and the boot up stops right there. 

console=ttyS0,115200n8 noinitrd rw ip=10.64.62.190:::255.254.0.0:karthikkit:eth0:off root=/dev/mtdblock3 rootfstype=jffs2

------------
And when i give the following bootargs linux asks does dhcp request and gets the ip but when i ping a machine it says network host unreachable. 

console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/mtdblock3 rootfstype=jffs2

------------

pls do reply.

karthik

       
---------------------------------
Got a little couch potato? 
Check out fun summer activities for kids.
