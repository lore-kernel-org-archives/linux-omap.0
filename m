From: "Anant Malewar" <anantm@motechsoftware.com>
Subject: RE: Write to file
Date: Wed, 9 Aug 2006 14:09:05 +0530
Message-ID: <AOEAJEHKCJCLCFFMGNFDEEGOCGAA.anantm@motechsoftware.com>
References: <20060808082259.38683.qmail@web51409.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060808082259.38683.qmail@web51409.mail.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: karthik karthik <skarthikeyan_17@yahoo.com>, Nirav Jani <nirav.jani@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Got the solution for this. I had to modify /etc/init.d/rcS
from "mount -n -o remount read-only /" to "mount -n -o remount /"

Thanks for your help.

Regards
Anant
  -----Original Message-----
  From: karthik karthik [mailto:skarthikeyan_17@yahoo.com]
  Sent: Tuesday, August 08, 2006 1:53 PM
  To: anantm@motechsoftware.com
  Subject: Re: Write to file


First of all if you use remount as told in the forum... you would have to
compile the remount application for ARM.In any case1) check your
/etc/exports file. see if there is rw or ro option2) check your kernel
command line parameters for rootfs.i think these two should solve the
problemregskarthikDate: Mon, 7 Aug 2006 18:13:17 +0530From: "Anant Malewar"
<anantm@motechsoftware.com>Subject: Write to fileTo:
<linux-omap-open-source@linux.omap.com>Message-ID:
<AOEAJEHKCJCLCFFMGNFDEEGICGAA.anantm@motechsoftware.com>Content-Type:
text/plain; charset="iso-8859-1"Hi,  I have an OSK 5912 rev C board. I am
able to boot it and mount thefilesystem over NFS. My application needs to
write some data in a file. Butthe filesystem is read only (/ is mounted as
read only). What do I need todo to make my application write to a file so
that I will be able to readthis file it on my host PC?Regards,Anant

----------------------------------------------------------------------------
--
  Do you Yahoo!?
  Next-gen email? Have it all with the all-new Yahoo! Mail Beta.


-------------------------------------------------------------------------------------------------------------------------------
DISCLAIMER:
This message (Including any attachments) is confidential and is intended only for the addressee. All MoTech Software mails and attachments are scanned for all known viruses at the time of transmission. However, please scan the mail and attachments for viruses before opening or downloading from this transmission. We will not accept any liability for damages through virus. If you are not the intended recipient or received this message by mistake, please notify the sender by E-mail & delete the message from the system. Any unauthorized use or dissemination of the message in whole or part is strictly prohibited.
