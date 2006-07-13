From: "Sanjiv Malik" <sanjiv@faith.co.jp>
Subject: deleting bootcmd boot argument
Date: Thu, 13 Jul 2006 15:53:55 +0900
Message-ID: <007201c6a649$1b865650$5a11a80a@smalik>
References: <7e6cc7550607122252s11b633bdh160f78a62caf65a4@mail.gmail.com>
	<d8c9df6c0607122316u486db3a6r142e4b550727b4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
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
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello friends,

     Currently iam facing with a problem on OMAP 2430.

    The problem is as follows:

    - I have set the u-boot environment variable "bootcmd" with the booting
      address of Kernel from flash
        i.e. setenv bootcmd bootm 0x04060000.
    - I have also set one more u-boot environment variable "bootdelay" to 0
        i.e. set bootdelay 0

    Due to these settings as soon as the board is switched ON, the linux
kernel from flash address is getting booted automatically through U-boot.

    Now, iam not able to boot the linux kernel from TFTP server.
    Even iam not able to set the following TFTP boot arguments:
     i.e. setenv bootargs
          set server ip
     because the kernel from flash gets booted automatically.

    Now, i wanna delete the bootcmd environment variable. May i know how can
i delete it so that i can set these TFTP boot arguments??

 Thanks in advance,
 Sanjiv



----- Original Message ----- 
From: "Mouhammad Tayseer Alquoatli" <idoit.ief@gmail.com>
To: "naga rajan" <nagubk82@gmail.com>
Cc: "Linux OMAP Open Source" <linux-omap-open-source@linux.omap.com>
Sent: Thursday, July 13, 2006 3:16 PM
Subject: Re: Flash recovery-regards


> On 7/13/06, naga rajan <nagubk82@gmail.com> wrote:
>>
>> Hi all,
>>
>>        I have a OSK5912 Revision D board. The u-boot in the flash got
>> corrupted.I like to regain the u-boot back to the flash. I tried with OSK
>> flash recovery utility provided in "CE LINUX FORUM" but could not 
>> download
>> the u-boot to the flash. Is there any contradiction between the board
>> revision and the flash recovery utility software?.
>>
>> Please provide a solution for this problem.
>
>
> Hi
> have you seen this:
> http://www.capgo.com/Resources/SoftwareDev/osk-newbie-guide.pdf
> one part is talking about installing a boot loader on a virgin system
> hope this helps
>
> Thanks in advance,
>> B.Nagarajan,
>> SANDS.
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>
>
>
> -- 
> Mouhammad Tayseer Alquoatli
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
