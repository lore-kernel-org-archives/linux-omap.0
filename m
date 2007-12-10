From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH RFC] OMAP: DMA: Cleanup of DMA Request Lines
Date: Mon, 10 Dec 2007 09:45:55 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804FE689E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

I'm resending this patch with the #else removed. I'm also sending a few
other ways in which we could do this.

Option 1:
Same patch as the last time without the #else

This contains lots of #ifdef statements but there are no #elses

Option 2:
No #ifdefs.

Using OMAP242X_* for 2420 specific names
OMAP243X_* for 2430 specific names/names present from 243X onwards
OMAP24XX_* for names common to all 24XX, 34XX
OMAP34XX_* for 34XX specific names

(or something similar could be worked out)

Option 3:

Name all possible names OMAP_* (or OMAP2_*) and use a runtime check to =
return
the correct request line number.

I'm sending sample patches for all three options. Let me know what you =
think.

Regards,
Anand
