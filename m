From: Philip Balister <philip@balister.org>
Subject: Re: jffs2 on osk5912
Date: Sun, 27 May 2007 09:27:17 -0400
Message-ID: <46598735.3040204@balister.org>
References: <913120.21031.qm@web51401.mail.re2.yahoo.com>
	<4658DDC5.9010801@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4658DDC5.9010801@css-design.us>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Steve Poulsen <spoulsen@css-design.us>
Cc: karthik <skarthikeyan_17@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You can also try flashing the images from here:

http://tree.celinuxforum.org/CelfPubWiki/OSK#head-6ce6c512ea433a7fc5c8841628e7696cd0ff7f2b

Philip


Steve Poulsen wrote:
> Try unprotecting your flash at the U-boot prompt:
> 
> protect off 1:23-255
> boot
> 
> You might need to adjust the numbers to match your system.  You can also 
> set the bootcmd to have the protect off and bootm commands together or 
> edit U-boot to unprotect part of the flash always.
> 
> Steve
> 
> karthik wrote:
>> Hi all,
>>
>> i tried mounting a jffs2 filesystem as root.
>>
>> i get the following the error a lot of times until no space is left 
>> (memory free is zero) in the system.
>>
>>  failed immediately: -EROFS. Is the sector locked?
>>
>> after this `mkdir` says there is no space.
>>
>> what's wrong?  The configuration i have chosen is exactly as given in 
>> oskfordummies site.
>>
>>
>> ----------
>>  
>> And when i give the following bootargs linux asks does dhcp request 
>> and the boot up stops right there.
>> console=ttyS0,115200n8 noinitrd rw 
>> ip=10.64.62.190:::255.254.0.0:karthikkit:eth0:off root=/dev/mtdblock3 
>> rootfstype=jffs2
>>
>> ------------
>> And when i give the following bootargs linux asks does dhcp request 
>> and gets the ip but when i ping a machine it says network host 
>> unreachable.
>> console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/mtdblock3 
>> rootfstype=jffs2
>>
>> ------------
>>
>> pls do reply.
>>
>> karthik
>>
>>        ---------------------------------
>> Got a little couch potato? Check out fun summer activities for kids.
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>>   
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
