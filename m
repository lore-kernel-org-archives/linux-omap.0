From: sudip midya <sudip06@yahoo.com>
Subject: dsplink...buffer pool and sma pool
Date: Sun, 23 Sep 2007 04:02:56 -0700 (PDT)
Message-ID: <649626.14843.qm@web33106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Everybody,
                    whats the difference between buffer pool and sma pool as given in dsplink ring io example? I am confused about the fixed bufer size option in sma pool, not sure what it implies. Can anybody clarify about it and explain a bit how to use it? In buffer pool, I am seeing that the struct BUFPOOL_Params

typedef struct BUFPOOL_Params_tag {
    Uint32     numBufObjs ;
    Uint32 *   bufSizes ;
    Uint32 *   numBuffers ;
    Uint16     segId ;
} BUFPOOL_Params ;



what to give it for segId if I want to use the buffer pool?


Thanks and Regards,
zix

       
---------------------------------
Boardwalk for $500? In 2007? Ha! 
Play Monopoly Here and Now (it's updated for today's economy) at Yahoo! Games.
