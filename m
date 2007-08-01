From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Keypad Application
Date: Wed, 1 Aug 2007 15:56:25 +0530
Message-ID: <5d5443650708010326h282244bs435069decd85d5ac@mail.gmail.com>
References: <c656a4d20708010028n5b52efb2yb14d36344f9e9924@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20708010028n5b52efb2yb14d36344f9e9924@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Arun,

On 8/1/07, arun c <arun.edarath@gmail.com> wrote:
> Hi all,
>
> I want to write an application which will be using the keypad of omap2430SDP.
>
> can anybody tell me what driver interface i must use in my application??.
> The name of the device in /dev dir will be enough for me.
>
> whether the keypad driver in SDP is an event driver ??
>

You should use input subsystem layer for keypad. e.g
/dev/input/eventX. Please google "evtest.c" and you will get example
program on how to deal with keypad.

-- 
--Trilok Soni
