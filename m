From: "Michal Szabat" <michal611@interia.pl>
Subject: Re: "File not found" error while loading dspgateway demo
Date: Tue, 25 Apr 2006 15:30:59 +0200
Message-ID: <003601c6686c$7f004a80$0301a8c0@hydra>
References: <9713be7f0604250418t4cb184efke0bc07f88846b66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
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
To: Sergey Vointsev <vointsev@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

    Hello Sergey.
Probably the problem is with you device files under /dev directory. Do you 
use devfs or udev? If not, you can manually create file with command
mknod /dev/dsptask/demo_console.Why this file? See in file demo_console.c 
for arm. 


----------------------------------------------------------------------
Swietnie zdjecia do poogladania >>> http://link.interia.pl/f192b 
