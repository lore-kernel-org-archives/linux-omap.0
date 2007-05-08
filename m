From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: FW: How to implement JFFS2 filesystem on NAND
Date: Tue, 08 May 2007 07:10:52 -0500
Message-ID: <464068CC.5020200@gmail.com>
References: <42E999AD7A0E4647BF159F467EE4FBCB017B50F5@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <42E999AD7A0E4647BF159F467EE4FBCB017B50F5@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: sathish.madhava@wipro.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

sathish.madhava@wipro.com stated on 5/8/2007 6:45 AM:
> Hi,
> I changed my rootfs.
>
> But now I am getting the error message as below.
>
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00088024:
> 0xcf4e instead
>   
you dont have a jffs2 image in the device you gave it to / part of the
flash is empty.. Suggestion on jffs2 filesystem - use a working
filesystem - the same filesystem should work fine either as a RAMDISK(if
it is small) or as a NFS filesystem.
If this is proven, then another observation i have had in the past is
that certain flash parts might take a bit longer on the very first
mount(boot)- something like 20-30 mins.. give it an hr and see if the
garbage collector finished it's work.

> The information contained in this electronic message and any attachments
> to this message are intended for the exclusive use of the addressee(s)
> and may contain proprietary, confidential or privileged information. If
> you are not the intended recipient, you should not disseminate,
> distribute or copy this e-mail. Please notify the sender immediately and
> destroy all copies of this message and any attachments. 
>
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
>  
> www.wipro.com
>
> ______________________________________________________
>   
Please read thru email ettiquette of opensource list.. most of us frown
upon a disclaimer that contains proprietary yada yada... please contact
IT department and get this email list "white listed"..
Regards,
Nishanth Menon
