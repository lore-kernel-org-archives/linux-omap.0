From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Audio Specifications
Date: Tue, 20 Nov 2007 18:05:43 +0100
Message-ID: <474313E7.1040808@googlemail.com>
References: <867485.80159.qm@web7611.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <867485.80159.qm@web7611.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Azhar Mr. wrote:
> Hi,
>    
>   I am trying to play the audio files from OMAP5912 OSK by connecting an amplifier and speakers to the kit at HEADPHONE OUT end. But the output sound is very less whereas I am able to get high sounds when playing from a CD player or tape recorder.
>    
>                        I think there is an impedance mismatch between OMAP5912 and the amplifier which I am using. Any body Please help me in providing the audio specifications of the processor like output impedance, etc.

You should have OSK5912 schematic if you have a board. If not, have a 
look to section 5.6 (page 48) of

http://omap.spectrumdigital.com/osk5912/files/osk5912_hwspec.pdf

TLV320AIC23 datasheet you can get at

http://www-s.ti.com/sc/ds/tlv320aic23b.pdf

Regards

Dirk
