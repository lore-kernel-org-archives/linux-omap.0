From: Gururaj N <gururaj@sasken.com>
Subject: RE: File system in flash
Date: Tue, 16 May 2006 21:00:48 +0530 (IST)
Message-ID: <Pine.GSO.4.64.0605162056330.15200@sunm21.sasken.com>
References: <520AB2AD990DC04082102F77CA172638036D9CAA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset=US-ASCII;
	format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA172638036D9CAA@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

Using the below mentioned bootargs. I get following error message. Lools
like the memory address does not contain any filesyste,

setenv bootargs mem=32M console=ttyS0,115200n8 noinitrd 
root=/dev/mtdblock3 rootfstype=jffs2 devfs=mount ip=noip


NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000040: 
0xfeff instead
Empty flash at 0x00000044 ends at 0x000000bc
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x000000bc: 
0xffbf instead
Empty flash at 0x000000c0 ends at 0x00000104
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000104: 
0xffff instead
Empty flash at 0x00000108 ends at 0x0000014c
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000014c: 
0xffff instead
Empty flash at 0x00000150 ends at 0x0000016c


With Regards
Gururaj N

On Tue, 16 May 2006, Menon, Nishanth wrote:

>> How to specify for kernel bootup that filesytem resides at  specific
>> flash address ?
>
> Bootargs: e.g.:
> setenv bootargs mem=32M console=ttyS0,115200n8 noinitrd
> root=/dev/mtdblock3 rootfstype=jffs2 devfs=mount
>>
>> "SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA -
> SURVEY
>> 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"
>>
>>                            SASKEN BUSINESS DISCLAIMER
>> This message may contain confidential, proprietary or legally
> Privileged
>> information. In case you are not the original intended Recipient of
> the
>> message, you must not, directly or indirectly, use, Disclose,
> distribute,
>> print, or copy any part of this message and you are requested to
> delete it
>> and inform the sender. Any views expressed in this message are those
> of
>> the individual sender unless otherwise stated. Nothing contained in
> this
>> message shall be construed as an offer or acceptance of any offer by
>> Sasken Communication Technologies Limited ("Sasken") unless sent with
> that
>> express intent and with due authority of Sasken. Sasken has taken
> enough
>> precautions to prevent the spread of viruses. However the company
> accepts
>> no liability for any damage caused by any virus transmitted by this
> email
>
>
> This is a bad disclaimer to send to an opensource list.. please ask your
> mail admin to fix this.
> Regards,
> Nishanth Menon
>

"SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"

                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
