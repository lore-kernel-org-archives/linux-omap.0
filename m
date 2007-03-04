From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Broken ads7846 touchscreen, was: [PATCH] ARM: OMAP: Fix SPI merge
 issues and reintroduce omap_uwire.c
Date: Sun, 04 Mar 2007 17:38:36 +0100
Message-ID: <45EAF60C.5070207@googlemail.com>
References: <45EAB7F5.2040603@googlemail.com>
	<85tzx1gple.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <85tzx1gple.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Arnaud Patard (Rtp) wrote:
> Dirk Behme <dirk.behme@googlemail.com> writes:
> 
> 
>>Is there any special reason why
>>
>>http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=ba6d3cf6f7900c7586cca6bbd9dca55d7c6386fb
>>
>>deleted drivers/spi/omap_uwire.c?
> 
> 
> looks like forgotten git-update-index or something like that. I didn't
> check closely but I bet that this conflicts explains also why the
> ads7846 touchscreen driver doesn't work. I had to take the versions from
> the old linux-omap-2.6 tree to get my touchscreen back :(

Do you can make a diff between the old and new version and 
send a patch?

Cheers

Dirk
