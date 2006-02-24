From: "Michal Szabat" <michal611@interia.pl>
Subject: Re: NFS Mount a folder of host on OSK
Date: Fri, 24 Feb 2006 09:25:23 +0100
Message-ID: <004001c6391b$e2ad8280$0301a8c0@hydra>
References: <26d3a31c0602230816t46c8880dnb5466b7919babae3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
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
To: prafulla chandra vejendla <v.prafulla@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


----- Original Message ----- 
From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
To: <linux-omap-open-source@linux.omap.com>
Sent: Thursday, February 23, 2006 5:16 PM
Subject: NFS Mount a folder of host on OSK


I am using OMAP 5912 with the Linux kernel 2.4 that is supplied by the
vendor himself.
I have connected it to a Linux 9 Host PC via a serial and ethernet cable.
I am trying to mount a folder of the host PC on to the hardware.
I am using minicom on the Linux Host PC to talk to my hardware. I have not
installed my preview kit on the Linux host PC.
I have not changed any boot args of the hardware(OSK).

My /etc/exports file on the linux host is updated for the folder to be nfs
mounted. I have also executed the steps like
exportfs -a
portmap
nfsd

When i do a mount on the hardware (mount -t nfs <ip>:/osk /mnt) it fails
But i am able to ping my hardware ip from the linux host and also vice
versa.

Am i missing any step?
Advice me....

-vp
____________________________________________

Maybe You need set some boot parameters for the kernel, but I'm not sure.
I wanted to make it just with preview kit, but montawista have not sent 
passwords to me, and i compile the kernel 2.6.8-rc3, and mount root 
filesystem with NFS. It really works. This link can be helpful : 
http://www.capgo.com/Resources/SoftwareDev/osk-newbie-guide.pdf




----------------------------------------------------------------------
Ocen dziewczyny Playboya!!! >>> http://link.interia.pl/f190f
