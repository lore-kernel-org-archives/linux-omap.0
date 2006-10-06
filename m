From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: encoder audio or speech for omap5912
Date: Fri, 06 Oct 2006 17:03:18 +0200
Message-ID: <45267036.9000806@gmail.com>
References: <002e01c6e93e$d27fe8c0$5a4517ac@CibersiteIndia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <002e01c6e93e$d27fe8c0$5a4517ac@CibersiteIndia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: K S Shankar <sshanmugam@ciber.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

K S Shankar wrote:
>   *   - You have to provide appropriate defines for them in config.h, e.g. *
>   *     + define SIZEOF_SHORT to 2 if the size of a short is 2             *
>   *     + define WORDS_BIGENDIAN if your system is a big endian system     *

Maybe you should follow the advice the tool gives you?

OMAP is little endian. If you are unsure which sizes are 
correct for the various #define SIZEOF_xx try to write a 
short test program which does someting like

printf("Size of short: %i\n", sizeof(short));

etc.

Dirk
